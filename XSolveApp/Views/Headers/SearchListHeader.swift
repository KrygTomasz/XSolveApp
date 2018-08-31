//
//  SearchListHeader.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

class SearchListHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .lightGray
        }
    }
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.placeholder = "Search..."
        }
    }
    
}
