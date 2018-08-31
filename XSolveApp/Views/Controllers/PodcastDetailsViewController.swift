//
//  PodcastDetailsViewController.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

class PodcastDetailsViewController: UIViewController {
    
    var podcastViewModel: PodcastViewModel?
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 12.0
        }
    }
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var collectionTitleLabel: UILabel! {
        didSet {
            collectionTitleLabel.text = "from"
        }
    }
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var artistTitleLabel: UILabel! {
        didSet {
            artistTitleLabel.text = "by"
        }
    }
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Podcast details"
        self.view.backgroundColor = .lightGray
        updateUI()
    }
    
    func updateUI() {
        trackNameLabel.text = podcastViewModel?.trackName
        collectionNameLabel.text = podcastViewModel?.collectionName
        artistNameLabel.text = podcastViewModel?.artistName
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
