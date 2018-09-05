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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .tintColor
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([xCenterConstraint, yCenterConstraint])
        return activityIndicator
    }()
    
    var musicState: MusicState = .none {
        didSet {
            switch musicState {
            case .downloading:
                self.isEnabled = false
                self.showIndicator()
                self.setImage(nil, for: .normal)
            case .none:
                self.hideIndicator()
                self.isEnabled = false
                self.setImage(nil, for: .normal)
            case .paused:
                self.hideIndicator()
                self.isEnabled = true
                self.setImage(#imageLiteral(resourceName: "playIcon").withRenderingMode(.alwaysTemplate), for: .normal)
            case .playing:
                self.hideIndicator()
                self.isEnabled = true
                self.setImage(#imageLiteral(resourceName: "pauseIcon").withRenderingMode(.alwaysTemplate), for: .normal)
            }
            self.tintColor = .tintColor
        }
    }
    
    private func showIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    private func hideIndicator() {
        self.activityIndicator.stopAnimating()
    }
    
}
