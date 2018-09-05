//
//  MusicButton.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 05.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation
import UIKit

class MusicButton: UIButton {
        
    var musicState: MusicState = .none {
        didSet {
            switch musicState {
            case .downloading:
                self.isEnabled = false
                self.setImage(nil, for: .normal)
            case .none:
                self.isEnabled = false
                self.setImage(nil, for: .normal)
            case .paused:
                self.isEnabled = true
                self.setImage(#imageLiteral(resourceName: "playIcon").withRenderingMode(.alwaysTemplate), for: .normal)
            case .playing:
                self.isEnabled = true
                self.setImage(#imageLiteral(resourceName: "pauseIcon").withRenderingMode(.alwaysTemplate), for: .normal)
            }
            self.tintColor = .tintColor
        }
    }
    
}
