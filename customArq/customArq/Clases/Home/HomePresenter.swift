//
//  HomePresenter.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

protocol HomePresenterProtocol: BasePresenterProtocol {
    
}

protocol HomeInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}

class HomePresenter: BasePresenter {
    // MARK: VIPER Dependencies
    weak var view: HomeViewProtocol? { return super.baseView as? HomeViewProtocol }
    var router: HomeRouterProtocol? { return super.baseRouter as? HomeRouterProtocol }
    var interactor: HomeInteractorInputProtocol? { return super.baseInteractor as? HomeInteractorInputProtocol }
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        
    }
}
