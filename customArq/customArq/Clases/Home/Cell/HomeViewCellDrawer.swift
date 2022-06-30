//
//  HomeViewCellDrawer.swift
//  customArq
//
//  Created by angel.bayon on 1/7/22.
//

import UIKit

class HomeViewCellDrawer {
    static func cell(model: HomeViewCellModel, tableView: UITableView, presenter: Any?) -> UITableViewCell {
        guard let cell = BaseTableViewCell<Any>.createBaseCell(tableView: tableView, cell: HomeViewCell.self, cellName: HomeViewCell.nameOfClass, model: model) else { return UITableViewCell() }
                
        return cell
    }
}
