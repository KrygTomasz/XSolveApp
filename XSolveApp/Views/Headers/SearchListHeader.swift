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
            containerView.backgroundColor = .backgroundColor
        }
    }
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.placeholder = "search".localized() + "..."
            searchTextField.clearButtonMode = .whileEditing
            searchTextField.delegate = self
        }
    }
    
    weak var delegate: SearchListHeaderDelegate?
    
}

//MARK: UITextFieldDelegate
extension SearchListHeader: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var searchTerm = searchTextField.text ?? ""
        searchTerm = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
        if searchTerm.isEmpty {
            return false
        } else {
            delegate?.search(text: searchTerm)
            return textField.resignFirstResponder()
        }
    }
    
}
