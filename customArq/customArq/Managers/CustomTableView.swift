//
//  CustomTableView.swift
//  customArq
//
//  Created by angel.bayon on 30/6/22.
//

import Foundation
import UIKit

struct CustomTableView {
    var type: TableType
    var tableView: UITableView
    
    init(type: TableType = .unespecified, tableView: UITableView) {
        self.type = type
        self.tableView = tableView
    }
}
