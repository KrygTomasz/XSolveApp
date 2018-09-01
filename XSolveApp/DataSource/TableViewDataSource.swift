//
//  TableViewDataSource.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 01.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<Cell: UITableViewCell, ViewModel>: NSObject, UITableViewDataSource {
    
    private var cellIdentifier: String
    private var viewModels: [ViewModel]
    private var configureCell: (Cell, ViewModel) -> Void
    
    init(cellIdentifier: String, viewModels: [ViewModel], configureCell: @escaping (Cell, ViewModel) -> Void) {
        self.cellIdentifier = cellIdentifier
        self.viewModels = viewModels
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Cell else {
            NSLog("TableViewDataSource couldn't dequeue cell for identifier: \(cellIdentifier)")
            return UITableViewCell()
        }
        let viewModel = viewModels[indexPath.row]
        self.configureCell(cell, viewModel)
        return cell
    }
    
}
