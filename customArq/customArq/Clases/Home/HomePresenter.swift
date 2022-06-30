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
    
    weak var tablePresenterDelegate: TablePresenterDelegate?
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        
    }
}

extension HomePresenter: TablePresenterProtocol {
    func numberOfCells(_ tableType: TableType, section: Int) -> Int {
        return 1
    }
    
    func object(_ tableType: TableType, indexPath: IndexPath) -> Any {
        let model = HomeViewCellModel(demo: "prueba")
        
        return model
    }
}
