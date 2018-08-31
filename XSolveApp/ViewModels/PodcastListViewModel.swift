//
//  PodcastListViewModel.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation
import UIKit

class PodcastListViewModel {
    
    var podcastViewModels: [PodcastViewModel] = [PodcastViewModel]()
    var completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
        populatePodcasts()
    }
    
    private func populatePodcasts() {
        WebServiceManager.shared.downloadPodcasts { success, podcasts in
            self.podcastViewModels = podcasts.map(PodcastViewModel.init)
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }
    
    func podcastViewModel(at index: Int) -> PodcastViewModel {
        return podcastViewModels[index]
    }
    
}

class PodcastViewModel {
    
    var artistName: String
    var collectionName: String
    var trackName: String
    var artworkUrl100: String
    var trackPrice: Double
    var currency: String
    
    init(podcast: Podcast) {
        self.artistName = podcast.artistName
        self.collectionName = podcast.collectionName
        self.trackName = podcast.trackName
        self.artworkUrl100 = podcast.artworkUrl100
        self.trackPrice = podcast.trackPrice
        self.currency = podcast.currency
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        WebServiceManager.shared.downloadImage(from: artworkUrl100, completion: completion)
    }
    
}
