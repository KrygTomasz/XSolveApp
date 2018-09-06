//
//  UIViewController+Extensions.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 04.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func prepareNavigationBar(withTitle title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .backgroundColor
    }
    
}
