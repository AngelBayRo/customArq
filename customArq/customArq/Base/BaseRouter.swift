//
//  BaseRouter.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

import UIKit

class BaseRouter {
    // Declared weak for the ARC to destroy them.
    internal weak var baseView: UIViewController?
    
    required init() {}
    
    static func setRoot(navigationController: UIViewController) {
        guard let window = UIApplication.shared.delegate?.window else { return }
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
