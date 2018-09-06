//
//  String+Extensions.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 04.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
