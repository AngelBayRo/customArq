//
//  TableViewManager.swift
//  customArq
//
//  Created by angel.bayon on 30/6/22.
//

import Foundation
import UIKit

class TableViewManager: NSObject {
    var arrayTableViews: [CustomTableView] = []
    var lasContentOffsets: [CGPoint] = []
    weak var presenter: TablePresenterProtocol?
    weak var view: TableViewDelegate?
    
    init(arrayTableViews: [CustomTableView], presenter: Any?, view: Any? = nil) {
        super.init()
        
        self.arrayTableViews = arrayTableViews
        self.lasContentOffsets = arrayTableViews.map({ $0.tableView.contentOffset })
        self.presenter = presenter as? TablePresenterProtocol
        self.presenter?.tablePresenterDelegate = self
        self.view = view as? TableViewDelegate
        
        self.setup()
    }
    
    func setup() {
        for customTable in arrayTableViews {
            customTable.tableView.delegate = self
            customTable.tableView.dataSource = self
            
            customTable.tableView.separatorStyle = .none
            customTable.tableView.separatorColor = .clear
            customTable.tableView.separatorInset = .zero
            customTable.tableView.estimatedRowHeight = 44
        }
    }
    
    func findCustomTableView(_ tableView: UITableView, arrayCustomTables: [CustomTableView]) -> CustomTableView? {
        return arrayTableViews.filter({ $0.tableView == tableView }).first
    }
    
    func findTableView(_ tableType: TableType, arrayCustomTables: [CustomTableView]) -> UITableView? {
        return arrayTableViews.filter({ $0.type == tableType }).first?.tableView
    }
    
    func findTableViewIndex(_ tableType: TableType, arrayCustomTables: [CustomTableView]) -> Int? {
        return arrayTableViews.firstIndex(where: { $0.type == tableType })
    }
    
    func findTableViewIndex(_ tableView: UITableView) -> Int? {
        return arrayTableViews.firstIndex(where: { $0.tableView == tableView })
    }
}

extension TableViewManager: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let type = findCustomTableView(tableView, arrayCustomTables: arrayTableViews)?.type ?? .unespecified
        return presenter?.numberOfSections(type) ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = findCustomTableView(tableView, arrayCustomTables: arrayTableViews)?.type ?? .unespecified
        return presenter?.numberOfCells(type, section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = findCustomTableView(tableView, arrayCustomTables: arrayTableViews)?.type ?? .unespecified
        return CommonFactoryCells.cell(for: presenter?.object(type, indexPath:indexPath), tableView: tableView, delegate: presenter)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = findCustomTableView(tableView, arrayCustomTables: arrayTableViews)?.type ?? .unespecified
        presenter?.didTapRow(type, indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension TableViewManager: TablePresenterDelegate {
    func dataSourceUpdated(_ tableType: TableType) {
        findTableView(tableType, arrayCustomTables: arrayTableViews)?.reloadData()
    }
    
    func insertRowsAtIndex(_ tableType: TableType, _ indexPath: [IndexPath]) {
        let table = findTableView(tableType, arrayCustomTables: arrayTableViews)
        
        let oldContentHeight: CGFloat = table?.contentSize.height ?? 0
        let oldOffsetY: CGFloat = table?.contentOffset.y ?? 0
        
        table?.beginUpdates()
        table?.insertRows(at: indexPath, with: .automatic)
        table?.endUpdates()
        
        let newContentHeight: CGFloat = table?.contentSize.height ?? 0
        table?.contentOffset.y = oldOffsetY + (newContentHeight - oldContentHeight)
    }
}
