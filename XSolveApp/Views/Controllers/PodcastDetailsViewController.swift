//
//  PodcastDetailsViewController.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

class PodcastDetailsViewController: UIViewController {
    
    var podcastViewModel: PodcastViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

//MARK: Constructor
extension PodcastDetailsViewController {
    static func getInstance(using podcastViewModel: PodcastViewModel) -> PodcastDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let podcastDetailsVC = storyboard.instantiateViewController(withIdentifier: "PodcastDetailsViewController") as? PodcastDetailsViewController else {
            fatalError("Cannot instantiate PodcastDetailsViewController")
        }
        podcastDetailsVC.podcastViewModel = podcastViewModel
        return podcastDetailsVC
    }
}
