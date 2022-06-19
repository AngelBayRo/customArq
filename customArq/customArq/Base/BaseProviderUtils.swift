//
//  BaseProviderUtils.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

class BaseProviderUtils {
    // swiftlint:disable function_parameter_count
    static let dateFormat = "dd/MM/yyyy-HH:mm:ss"
    
    static func printRequest(dto: ProviderDTO, endpoint: String, headers: [String: Any], printData: Bool) {
        
        let data = dto.arrayParams != nil
        ? try? JSONSerialization.data(withJSONObject: (dto.arrayParams ?? [:]), options: .prettyPrinted)
        : try? JSONSerialization.data(withJSONObject: (dto.params ?? []), options: .prettyPrinted)
        
        Utils.print("************* REQUEST **************")
        Utils.print("Request Date: \(Date().format(format: dateFormat))")
        Utils.print("URL: \(endpoint)")
        if printData {
            Utils.print("PARAMETERS: ")
            Utils.print(String(data: data ?? Data(), encoding: .utf8) ?? "")
            Utils.print("HEADERS: \(headers)")
        }
        Utils.print("************* END *************")
    }
    
    static func printSuccessResponse(endpoint: String, data: Data, decryptedBytes: Data?, printData: Bool) {
        Utils.print("*************************** RESPONSE ***************************")
        Utils.print("Response Date: \(Date().format(format: dateFormat))")
        Utils.print("URL: \(endpoint)")
        if printData {
            Utils.print(String(data: data, encoding: .utf8) ?? "")
            // Utils.print(String(data: decryptedBytes ?? Data(), encoding: .utf8) ?? "")
        }
        
        Utils.print("********* END ***********")
    }
    
    static func printFailureResponse(endpoint: String, data: Data?, decryptedBytes: Data?, printData: Bool) {
        
        Utils.print("*************************** RESPONSE ***************************")
        Utils.print("Response Date: \(Date().format(format: dateFormat))")
        Utils.print("URL: \(endpoint)")
        
        if printData {
            Utils.print(String(data: data ?? Data(), encoding: .utf8) ?? "")
            // Utils.print(String(data: decryptedBytes ?? Data(), encoding: .utf8) ?? "")
        }
    }
    
    
    static func manageResponseData(data: Data?, encrypted: Bool) -> Data? {
        guard let data = data else { return nil }
        
        var decryptedBytes: Data?
        
        if encrypted {
            // Desencriptar
        } else {
            decryptedBytes = data
        }
        
        return decryptedBytes
    }
    
    static func apiResponseError(responseData: Data?, responseStatusCode: Int?, failure: @escaping (CustomErrorModel) -> Void) {
        let customError: CustomErrorModel
        switch responseStatusCode {
        case HTTPClientError.ErrorType.notFound.rawValue:
            customError = CustomErrorModel(data: responseData, httpCode: HTTPClientError.ErrorType.notFound.rawValue)
        default:
            customError = CustomErrorModel(data: responseData, httpCode: HTTPClientError.ErrorType.unknownError.rawValue)
        }
        
        Utils.print(customError)
        Utils.print("*************************** END ***************************")
        
        failure(customError)
    }
    
    
    static func manageResponse(endpoint: String, response: HTTPURLResponse, data: Data?, encrypted: Bool, printLog: Bool, success: (Data?) -> Void, failure: @escaping (CustomErrorModel) -> Void) {
        print(response.statusCode)
        if (200..<300).contains(response.statusCode) {
            // Gestión del caso correcto
            // Se obtiene la respuesta.
            guard let data = data else {
                // Si la respuesta no tiene datos, se devuelve un error.
                self.apiResponseError(responseData: nil,
                                      responseStatusCode: response.statusCode,
                                      failure: failure)
                return
            }
            
            let decryptedBytes = BaseProviderUtils.manageResponseData(data: data, encrypted: encrypted)
            
            printSuccessResponse(endpoint: endpoint, data: data, decryptedBytes: decryptedBytes, printData: printLog)
            
            success(decryptedBytes)
        } else {
            let decryptedBytes = BaseProviderUtils.manageResponseData(data: data, encrypted: encrypted)
            
            printFailureResponse(endpoint: endpoint, data: data, decryptedBytes: decryptedBytes, printData: printLog)
            
            apiResponseError(responseData: decryptedBytes,
                             responseStatusCode: response.statusCode,
                             failure: failure)
            return
        }
    }
    
    static func parseToServerModel<M: BaseServerModel>(parserModel: M.Type, data: Data?) -> M? {
        
        guard let payload = data else {
            return nil
        }
        var model: M?
        do {
            model = try JSONDecoder().decode(parserModel, from: payload)
        } catch {
            print(error)
        }
        return model
    }
    
    static func parseArrayToServerModel<M: BaseServerModel>(parserModel: [M].Type, data: Data?) -> [M]? {
        
        guard let payload = data, let arrayModels = try? JSONDecoder().decode(parserModel, from: payload) else {
            return nil
        }
        return arrayModels
    }
    
}
