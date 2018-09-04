//
//  PodcastDetailsViewModel.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 04.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation
import UIKit

class PodcastDetailsViewModel {
    
    private var podcastViewModel: PodcastViewModel
    
    var trackName: String {
        guard let track = podcastViewModel.trackName else {
            return "–"
        }
        return track
    }
    
    var collectionName: String {
        if collectionIsHidden {
            return ""
        }
        return podcastViewModel.collectionName ?? ""
    }
    
    var artistName: String {
        if artistIsHidden {
            return ""
        }
        return podcastViewModel.artistName ?? ""
    }
    
    var priceText: String {
        guard
            let price = podcastViewModel.trackPrice,
            let currency = podcastViewModel.currency
        else {
            return "–"
        }
        return "\(price) \(currency)"
    }
    
    var collectionIsHidden: Bool {
        guard let _ = podcastViewModel.collectionName else {
            return true
        }
        return false
    }
    
    var artistIsHidden: Bool {
        guard let _ = podcastViewModel.artistName else {
            return true
        }
        return false
    }
    
    init(using podcastViewModel: PodcastViewModel) {
        self.podcastViewModel = podcastViewModel
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        ImageDownloader.downloadImage(from: podcastViewModel.artworkUrl100, completion: completion)
    }
    
}
