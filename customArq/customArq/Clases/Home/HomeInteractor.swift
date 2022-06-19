//
//  HomeInteractor.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

protocol HomeInteractorInputProtocol: BaseInteractorInputProtocol {
    
}

class HomeInteractor: BaseInteractor {
    // MARK: VIPER Dependencies
    weak var presenter: HomeInteractorOutputProtocol? {
        return super.basePresenter as? HomeInteractorOutputProtocol
    }
    
    var homeAssemblyDTO: HomeAssemblyDTO?
    var provider: HomeProviderProtocol?
}

extension HomeInteractor: HomeInteractorInputProtocol {
    
}
