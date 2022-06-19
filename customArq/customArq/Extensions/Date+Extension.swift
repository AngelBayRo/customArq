//
//  Date+Extension.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

extension Date {
    func format(format: String = Constants.dateFormat) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "es_ES")
        
        return dateFormatter.string(from: self)
    }
}
