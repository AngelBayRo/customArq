//
//  BaseTableViewCell.swift
//  customArq
//
//  Created by angel.bayon on 1/7/22.
//

import Foundation
import UIKit

class BaseTableViewCell<M: Any>: UITableViewCell {
    var cellModel: M?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        self.selectionStyle = .none
    }
    
    func configure(cellModel: M) {
        self.cellModel = cellModel
    }
}

extension BaseTableViewCell {
    static func createCell<T: UITableViewCell>(tableView: UITableView, cell: T.Type, cellName: String) -> T? {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? T
        
        if cell == nil {
            tableView.register(UINib(nibName: cellName, bundle: .main), forCellReuseIdentifier: cellName)
            cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? T
        }
        
        return cell
    }
    
    static func createBaseCell<M: Any, C: BaseTableViewCell<M>>(tableView: UITableView, cell: C.Type, cellName: String, model: M) -> C? {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? C
        
        if cell == nil {
            tableView.register(UINib(nibName: cellName, bundle: .main), forCellReuseIdentifier: cellName)
            cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? C
        }
        
        cell?.configure(cellModel: model)
        
        return cell
    }
}
