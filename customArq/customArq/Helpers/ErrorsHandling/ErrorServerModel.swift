//
//  ErrorServerModel.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

struct ErrorServerModel: BaseServerModel {
    let errors: [ServerStatusModel]?
}

struct ServerStatusModel: BaseServerModel {
    let status: String?
    let detail: String?
    
    init(status: String, detail: String) {
        self.status = status
        self.detail = detail
    }
}
