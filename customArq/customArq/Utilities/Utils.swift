//
//  Utils.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

class Utils {
    static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        var idx = items.startIndex
        let endIdx = items.endIndex
        
        repeat {
            Swift.print(items[idx], separator: separator, terminator: idx == (endIdx - 1) ? terminator : separator)
            idx += 1
        } while idx < endIdx
    }
}
