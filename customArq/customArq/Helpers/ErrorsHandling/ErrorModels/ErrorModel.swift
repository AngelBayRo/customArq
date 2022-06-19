//
//  ErrorModel.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

class ErrorModel: BaseBusinessModel {
    var state: ServerStatusModel?
    
    required init(serverModel: BaseServerModel?) {
        super.init(serverModel: serverModel)
        
        guard let serverModel = serverModel as? ErrorServerModel else { return }
        let components = serverModel.errors
        
        let element = components?.first
        
        self.state = ServerStatusModel(status: element?.status ?? "", detail: element?.detail ?? "")
    }
}
