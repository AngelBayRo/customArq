//
//  HomeProvider.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

protocol HomeProviderProtocol: AnyObject {
    func getHome(success: @escaping (HomeServerModel) -> Void,
                 failure: @escaping (CustomErrorModel) -> Void)
}

final class HomeProvider: BaseProvider, HomeProviderProtocol {
    func getHome(success: @escaping (HomeServerModel) -> Void, failure: @escaping (CustomErrorModel) -> Void) {
        
        let dto = HomeProviderRequest.getHomeConstants(params: nil)
        
        _ = self.request(
            dto: dto,
            additionalHeader: ["Content-Type": "application/json"],
            isSecure: true,
            success: { data in
                guard let data = data else {
                    //failure()
                    return
                }
                
                guard
                    let model = BaseProviderUtils.parseToServerModel(parserModel: HomeServerModel.self, data: data)
                else {
                    //failure()
                    return

                }
                success(model)
                
        }, failure: { error in
            failure(error)
        })
    }
    
}

struct HomeDTO: BaseProviderParamsDTO {
    
}

struct HomeProviderRequest {
    static func getHomeConstants(params: BaseProviderParamsDTO?) -> ProviderDTO {
        return ProviderDTO(arrayParams: params?.encode(),
                           method: .get,
                           endpoint: URLEndpoint.home,
                           urlContext: URLEndpoint.BaseURLContext.backend)
    }
}
