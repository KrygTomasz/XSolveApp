//
//  ProgressHUD.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 06.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

import MBProgressHUD

final class ProgressHUD {
    
    private init() {}
    
    static let shared = ProgressHUD()
    private var progressHUD : MBProgressHUD = MBProgressHUD()
    private weak var navigationController: UINavigationController?
    
    func prepare(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showActivityIndicator(title: String) {
        if let navController = self.navigationController {
            self.progressHUD = MBProgressHUD.showAdded(to: navController.view, animated: true)
            self.progressHUD.mode = MBProgressHUDMode.indeterminate
            self.progressHUD.label.text = title
            self.progressHUD.activityIndicatorColor = UIColor.black
            self.progressHUD.label.textColor = UIColor.black
            self.progressHUD.dimBackground = true
        }
    }
    
    func hideActivityIndicator() {
        self.progressHUD.hide(animated: true)
    }
    
}
