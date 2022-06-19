//
//  HomeRouter.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation


protocol HomeRouterProtocol: BaseRouterProtocol {
    
}

final class HomeRouter: BaseRouter {
    weak var view: HomeViewProtocol? {
        return super.baseView as? HomeViewProtocol }
}

extension HomeRouter: HomeRouterProtocol {
    
}
