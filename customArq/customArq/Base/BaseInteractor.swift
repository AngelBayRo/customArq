//
//  BaseInteractor.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

class BaseInteractor {
    // Declared weak for the ARC to destroy them.
    internal weak var basePresenter: BaseInteractorOutputProtocol?
    
    required init() {}    
}
