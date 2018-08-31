//
//  PodcastListViewModel.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

class PodcastListViewModel {
    
    var podcastViewModels: [PodcastViewModel] = [PodcastViewModel]()
    
    init(completion: @escaping () -> ()) {
        WebServiceManager.shared.downloadPodcasts { success, podcasts in
            self.podcastViewModels = podcasts.map(PodcastViewModel.init)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
}

class PodcastViewModel {
    
    var artistName: String
    var collectionName: String
    var trackName: String
    
    init(podcast: Podcast) {
        self.artistName = podcast.artistName
        self.collectionName = podcast.collectionName
        self.trackName = podcast.trackName
    }
    
}
