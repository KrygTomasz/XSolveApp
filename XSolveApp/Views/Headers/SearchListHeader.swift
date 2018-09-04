//
//  SearchListHeader.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

protocol SearchListHeaderDelegate: class {
    func search(text: String)
}

class SearchListHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .lightGray
        }
    }
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.placeholder = "Search..."
            searchTextField.delegate = self
        }
    }
    
    weak var delegate: SearchListHeaderDelegate?
    
}

extension SearchListHeader: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let searchTerm = searchTextField.text ?? ""
        delegate?.search(text: searchTerm)
        return textField.resignFirstResponder()
    }
    
}
