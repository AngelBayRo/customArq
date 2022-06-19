//
//  BaseProtocols.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

protocol BaseViewControllerProtocol: AnyObject {
    var basePresenter: BasePresenterProtocol? {get set}
}

// Protocol used to the Presenter can communicate with View
protocol BaseViewProtocol: AnyObject {
    
}

// Protocol used to the View can communicate with Presenter
protocol BasePresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear(isFirstPresentation: Bool)
    func viewDidAppear(isFirstPresentation: Bool)
}

extension BasePresenterProtocol {
    func viewDidLoad() {
        // Optional method
    }
    func viewWillAppear(isFirstPresentation: Bool) {
        // Optional method
    }
    func viewDidAppear(isFirstPresentation: Bool) {
        // Optional method
    }
}

// Protocol used to the Presenter can communicate with Interactor
protocol BaseInteractorInputProtocol: AnyObject {

}

// Protocol used to the Interactor can communicate with Presenter
protocol BaseInteractorOutputProtocol: AnyObject {
    
}

// Protocol used to the Presenter can communicate with Router
protocol BaseRouterProtocol: AnyObject {
    
}
