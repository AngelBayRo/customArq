//
//  TableProtocols.swift
//  customArq
//
//  Created by angel.bayon on 30/6/22.
//

import Foundation
import UIKit

enum TableType {
    case home
    case unespecified
}

protocol TablePresenterProtocol: AnyObject {
    var tablePresenterDelegate: TablePresenterDelegate? { get set }
    
    func numberOfSections(_ tableType: TableType) -> Int
    func numberOfCells(_ tableType: TableType, section: Int) -> Int
    func object(_ tableType: TableType, indexPath: IndexPath) -> Any
    func didTapRow(_ tableType: TableType, indexPath: IndexPath)
}

extension TablePresenterProtocol {
    func numberOfSections(_ tableType: TableType) -> Int { return 1 }
    func didTapRow(_ tableType: TableType, indexPath: IndexPath) {
        // Optional method
    }
}

protocol TablePresenterDelegate: AnyObject {
    func dataSourceUpdated(_ tableType: TableType)
    func insertRowsAtIndex(_ tableType: TableType, _ indexPath: [IndexPath])
}

protocol TableViewDelegate: AnyObject {
    func scrollViewDidScroll(scrollView: UIScrollView)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
}

extension TableViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) { }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { }
}
