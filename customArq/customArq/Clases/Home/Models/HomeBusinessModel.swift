//
//  HomeBusinessModel.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

class HomeBusinessModel: BaseBusinessModel {
    
    required init(serverModel: BaseServerModel?) {
        super.init(serverModel: serverModel)
        
        guard let serverModel = serverModel as? HomeServerModel else { return }
    }
}
