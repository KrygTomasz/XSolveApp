//
//  PodcastViewModel.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 01.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

class PodcastViewModel {
    
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var previewUrl: String?
    var artworkUrl100: String?
    var trackPrice: Double?
    var currency: String?
    
    init(podcast: Podcast) {
        self.artistName = podcast.artistName
        self.collectionName = podcast.collectionName
        self.trackName = podcast.trackName
        self.previewUrl = podcast.previewUrl
        self.artworkUrl100 = podcast.artworkUrl100
        self.trackPrice = podcast.trackPrice
        self.currency = podcast.currency
    }
    
}
