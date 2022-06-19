//
//  CustomErrorModel.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

class CustomErrorModel: NSError {
    var type: String = "Backend"
    var internalCode: String = ""
    var presentationMessage = ""
    var originalObject: Any?
    
    var httpClientError = HTTPClientError(code: HTTPClientError.ErrorType.unknownError.rawValue)
    var backendError = BackendError(code: "", serverMessage: "")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(httpClientError: HTTPClientError.ErrorType, backendError: BackendError.ErrorType) {

        self.httpClientError = HTTPClientError(code: httpClientError.rawValue)
        self.backendError = BackendError(code: backendError.rawValue, serverMessage: "")
        let defaultDomain = LocalizedKeys.ErrorMessage.generic
        self.presentationMessage = self.backendError.errorText

        super.init(domain: defaultDomain, code: self.httpClientError.type.rawValue, userInfo: nil)

    }
    
    init(data: Data?, httpCode: Int?) {
        self.httpClientError = HTTPClientError(code: httpCode ?? HTTPClientError.ErrorType.unknownError.rawValue)
        
        let defaultDomain = LocalizedKeys.ErrorMessage.generic
        let defaultCode = self.httpClientError.type.rawValue
        
        guard let data = data else {
            super.init(domain: defaultDomain, code: defaultCode, userInfo: nil)
            self.presentationMessage = defaultDomain
            return
        }
        
        if  let errorLoginModelModel = try? JSONDecoder().decode(ErrorServerModel.self, from: data) {
            
            let errorLoginModel = ErrorModel(serverModel: errorLoginModelModel)
            let domain = errorLoginModel.state?.detail ?? defaultDomain
            super.init(domain: domain,
                       code: defaultCode,
                       userInfo: nil)
            self.backendError = BackendError(code: errorLoginModel.state?.status ?? "",
                                             serverMessage: errorLoginModel.state?.detail ?? "")
            self.presentationMessage = backendError.serverMessage
            self.originalObject = errorLoginModel
            self.internalCode = errorLoginModel.state?.status ?? ""
            
            self.backendError = BackendError(code: errorLoginModel.state?.status ?? "",
                                             serverMessage: errorLoginModel.state?.detail ?? "")
            if presentationMessage.isEmpty {
                presentationMessage = LocalizedKeys.ErrorMessage.unknown
            }
            return
        }
        
        super.init(domain: defaultDomain, code: defaultCode, userInfo: nil)
        self.presentationMessage = self.backendError.serverMessage
    }
    
    init(withCustomMessage message: String, code: Int = HTTPClientError.ErrorType.unknownError.rawValue) {
        super.init(domain: "", code: code, userInfo: nil)
        self.presentationMessage = message
    }
}
