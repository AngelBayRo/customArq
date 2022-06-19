//
//  KnownErrors.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation
import FileProvider

public struct HTTPClientError: Error {
    var type: ErrorType = .unknownError
    
    enum ErrorType: Int {
        case notFound = 404
        case networkError = 408
        case unknownError = -1
    }
    
    init(code: Int) {
        if let errorCode = ErrorType(rawValue: code) {
            self.type = errorCode
        }
    }
}

public struct BackendError: Error {
    var type: ErrorType = .unknownError
    var code: String = ""
    var serverMessage = ""
    var errorText = ""
    
    enum ErrorType: String {
        case unknownError = ""
        case invalidUser = "invalid_user"
    }
    
    init(code: String, serverMessage: String) {
        self.type = ErrorType(rawValue: serverMessage) ?? .unknownError
        self.errorText = BackendError.getErrorTextFrom(self.type)
        self.code = code
        self.serverMessage = serverMessage
    }
    
    static func getErrorTextFrom(_ type: ErrorType) -> String {
        switch type {
        case .unknownError:
            return ""
        case .invalidUser:
            return "invalid_user".localizedCapitalized
        }
    }
}
