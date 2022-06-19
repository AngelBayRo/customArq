//
//  NativeManager.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

class NativeManager: RequestManager {
    // swiftlint:disable function_parameter_count
    // swiftlint:disable multiple_closures_with_trailing_closure
    var requestHttpHeaders = RestEntity()
    var urlQueryParameters = RestEntity()
    var httpBodyParameters = RestEntity()
    
    func request(dto: ProviderDTO, timeout: TimeInterval, printLog: Bool, encrypted: Bool, additionalHeader: [String: String], success: @escaping (Data?) -> Void, failure: @escaping (CustomErrorModel) -> Void) -> URLSessionTask? {
        
        let endpoint = URLEndpoint.buildURL(urlContext: dto.urlContext, endpoint: dto.endpoint)
        
        for currentHeader in additionalHeader {
            requestHttpHeaders.add(value: currentHeader.value, forKey: currentHeader.key)
        }
        
        var targetURL = URL(string: endpoint)
        
        if let params = dto.params {
            for param in params {
                let value: String = (param.value as? String) ?? "\(param.value)"
                
                if dto.method == .get || dto.method == .postURL {
                    urlQueryParameters.add(value: value, forKey: param.key)
                    targetURL = self.addURLQueryParameters(toURL: URL(string: endpoint)!)
                } else {
                    httpBodyParameters.add(value: value, forKey: param.key)
                }
            }
        }
        
        let httpBody: Data? = dto.method != .get ?  self.getHttpBody(dto: dto) : nil
        let httpMethod: HTTPMethod = dto.method == .postURL ? .post : dto.method
        
        guard let request = self.prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: httpMethod) else {
            failure(CustomErrorModel(httpClientError: .unknownError, backendError: .unknownError))
            return nil
        }
        
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                BaseProviderUtils.manageResponse(endpoint: endpoint, response: httpResponse, data: data, encrypted: encrypted, printLog: printLog, success: { (data) in
                    success(data)
                }) { (error) in
                    failure(error)
                }
            } else {
                let customError = CustomErrorModel(withCustomMessage: LocalizedKeys.ErrorMessage.network, code: HTTPClientError.ErrorType.networkError.rawValue)
                
                failure(customError)
            }
        }
        task.resume()
        return task
    }
    
    // MARK: - Private Methods
    
    private func addURLQueryParameters(toURL url: URL) -> URL {
        if urlQueryParameters.totalItems() > 0 {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
            var queryItems = [URLQueryItem]()
            if urlComponents.queryItems == nil {
                urlComponents.queryItems = queryItems
            }
            
            for (key, value) in urlQueryParameters.allValues() {
                let item = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
                
                queryItems.append(item)
                urlComponents.queryItems?.append(item)
            }
            
            guard let updatedURL = urlComponents.url else { return url }
            return updatedURL
        }
        
        return url
    }
    
    private func getHttpBody(dto: ProviderDTO? = nil) -> Data? {
        guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") as? String else { return nil }
        
        if contentType.contains("application/json") {
            if let dto = dto {
                return try? JSONSerialization.data(withJSONObject: (dto.params ?? [:]), options: [.prettyPrinted, .sortedKeys])
            } else {
                let body = try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(), options: [.prettyPrinted, .sortedKeys])
                return body
            }
            
        } else if contentType.contains("application/x-www-form-urlencoded") {
            let bodyString = httpBodyParameters.allValues().map { "\($0)=\(String(describing: "\($1)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))" }.joined(separator: "&")
            return bodyString.data(using: .utf8)
        } else {
            return nil
        }
    }
    
    private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HTTPMethod) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpShouldHandleCookies = true
        
        for (header, value) in requestHttpHeaders.allValues() {
            request.setValue("\(value)", forHTTPHeaderField: header)
        }
        
        request.httpBody = httpBody
        return request
    }
    
    struct RestEntity {
        private var values: [String: Any] = [:]
        
        mutating func add(value: Any, forKey key: String) {
            values[key] = value
        }
        
        func value(forKey key: String) -> Any? {
            return values[key]
        }
        
        func allValues() -> [String: Any] {
            return values
        }
        
        func totalItems() -> Int {
            return values.count
        }
    }
}
