//
//  BasePresenter.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation
import UIKit

class BasePresenter {
    // Declared weak for the ARC to destroy them.
    internal weak var baseView: BaseViewProtocol?
    internal var baseRouter: BaseRouterProtocol?
    internal var baseInteractor: BaseInteractorInputProtocol?
    
    required init() {}
}
