//
//  NSObject+Extensions.swift
//  customArq
//
//  Created by angel.bayon on 1/7/22.
//

import Foundation
import UIKit

extension NSObject {
    class var nameOfClass: String { return String(describing: self) }
    var nameOfClass: String { return String(describing: type(of: self)) }
}
