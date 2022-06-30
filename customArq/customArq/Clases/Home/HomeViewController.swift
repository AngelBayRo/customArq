//
//  HomeViewController.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import UIKit

protocol HomeViewProtocol: BaseViewProtocol {
    
}

class HomeViewController: BaseView {
    var presenter: HomePresenterProtocol? { return basePresenter as? HomePresenterProtocol }
    
    var tableViewManager: TableViewManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableManager()
    }
    
    func setUpTableManager() {
        tableViewManager = TableViewManager(arrayTableViews: [CustomTableView(type: TableType.home, tableView: UITableView())], presenter: presenter, view: self)
    }
}

extension HomeViewController: HomeViewProtocol {
    
}
