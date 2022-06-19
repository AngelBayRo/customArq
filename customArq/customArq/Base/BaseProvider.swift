//
//  BaseProvider.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

enum AcceptResponseType {
    case json
    case pdf
    case xml
    case text
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case postURL = "POST_URL"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

struct ProviderDTO {
    var params: [String: Any]?
    var arrayParams: [[String: Any]]?
    var method: HTTPMethod
    var urlContext: URLEndpoint.BaseURLContext
    var endpoint: String
    var acceptType = AcceptResponseType.json

    init(params: [String: Any]?,
         method: HTTPMethod,
         urlContext: URLEndpoint.BaseURLContext,
         endpoint: String,
         acceptType: AcceptResponseType = .json) {

        self.params = params
        self.method = method
        self.urlContext = urlContext
        self.endpoint = endpoint
        self.acceptType = acceptType
    }

    init(arrayParams: [[String: Any]]?,
         method: HTTPMethod,
         endpoint: String,
         urlContext: URLEndpoint.BaseURLContext,
         acceptType: AcceptResponseType = .json) {

        self.arrayParams = arrayParams
        self.method = method
        self.urlContext = urlContext
        self.endpoint = endpoint
        self.acceptType = acceptType
    }
}

class BaseProvider: NSObject {
    // swiftlint:disable multiple_closures_with_trailing_closure
    var task: URLSessionTask?
    
    var manager: RequestManager?
    
    internal func request(dto: ProviderDTO, timeout: TimeInterval = 15, printLog: Bool = true, encrypted: Bool = false, additionalHeader: [ String: String] = [:], isSecure: Bool = false, isLogin: Bool = false,
                          success: @escaping(Data?) -> Void, failure: @escaping(CustomErrorModel) -> Void) -> URLSessionTask? {
        if let manager = self.manager {
            let request = manager.request(dto: dto, timeout: timeout, printLog: printLog, encrypted: encrypted, additionalHeader: additionalHeader, success: { (data) in
                
                DispatchQueue.main.async {
                   success(data)
                }
            }) { (error) in
                DispatchQueue.main.async {
                    failure(error)
                }
            }
            self.task = request
            return request
        } else {
            let error = CustomErrorModel(httpClientError: .notFound, backendError: .invalidUser)
            failure(error)
            return nil
        }
    }
}

protocol RequestManager {
    func request(dto: ProviderDTO, timeout: TimeInterval, printLog: Bool, encrypted: Bool, additionalHeader: [ String: String], success: @escaping(Data?) -> Void, failure: @escaping(CustomErrorModel) -> Void) -> URLSessionTask?
}


protocol BaseProviderParamsDTO: Codable { }

extension BaseProviderParamsDTO {
    func encode() -> [[String: Any]] {
        guard let jsonData = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] else {
            return [[String: Any]]()
        }
        
        return json
    }
}
