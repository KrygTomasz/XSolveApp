//
//  PodcastDetailsViewController.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

class PodcastDetailsViewController: UIViewController {
    
    var podcastDetailsViewModel: PodcastDetailsViewModel?
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 12.0
        }
    }
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.textColor = .lightGray
        }
    }
    @IBOutlet weak var coverContentView: UIView! {
        didSet {
            coverContentView.isHidden = true
        }
    }
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var collectionContentView: UIView!
    @IBOutlet weak var collectionTitleLabel: UILabel! {
        didSet {
            collectionTitleLabel.text = "from"
        }
    }
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var artistContentView: UIView!
    @IBOutlet weak var artistTitleLabel: UILabel! {
        didSet {
            artistTitleLabel.text = "by"
        }
    }
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationBar(withTitle: "podcastDetails".localized())
        self.view.backgroundColor = .backgroundColor
        updateUI()
    }
    
    private func updateUI() {
        prepareData()
        prepareViews()
    }
    
    private func prepareData() {
        guard let vm = podcastDetailsViewModel else { return }
        priceLabel.text = vm.priceText
        trackNameLabel.text = vm.trackName
        collectionNameLabel.text = vm.collectionName
        artistNameLabel.text = vm.artistName
        vm.loadImage { [weak self] image in
            DispatchQueue.main.async {
                self?.prepareCover(image)
            }
        }
    }
    
    private func prepareViews() {
        guard let vm = podcastDetailsViewModel else { return }
        collectionContentView.isHidden = vm.collectionIsHidden
        artistContentView.isHidden = vm.artistIsHidden
    }
    
    private func prepareCover(_ image: UIImage?) {
        if let imageObj = image {
            self.coverImageView.image = imageObj
            self.coverContentView.isHidden = false
        } else {
            self.coverContentView.isHidden = true
        }
    }

}

//MARK: Constructor
extension PodcastDetailsViewController {
    static func getInstance(using podcastDetailsViewModel: PodcastDetailsViewModel) -> PodcastDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let podcastDetailsVC = storyboard.instantiateViewController(withIdentifier: "PodcastDetailsViewController") as? PodcastDetailsViewController else {
            fatalError("Cannot instantiate PodcastDetailsViewController")
        }
        podcastDetailsVC.podcastDetailsViewModel = podcastDetailsViewModel
        return podcastDetailsVC
    }
}
