//
//  CommonFactoryCells.swift
//  customArq
//
//  Created by angel.bayon on 30/6/22.
//

import UIKit

class CommonFactoryCells: NSObject {
    class func cell(for object: Any?, tableView: UITableView, delegate: Any? = nil) -> UITableViewCell {
        switch object {
        case let model as HomeViewCellModel:
            return HomeViewCellDrawer.cell(model: model, tableView: tableView, presenter: delegate)
        default: return UITableViewCell()
        }
    }
    
    class func cell(for object: Any?, collectionView: UICollectionView, delegate: Any? = nil, indexPAth: IndexPath) -> UICollectionViewCell {
        switch object {
        //case let model as HomeCollectionCellModel:
        //    return HomeCollectionCellDrawer.cell(model: model, tableView: tableView, presenter: delegate)
        default: return UICollectionViewCell()
        }
    }
}
