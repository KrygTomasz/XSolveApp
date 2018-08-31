//
//  Podcast.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

class PodcastList: Codable {
    
    var results: [Podcast] = []
    
}

class Podcast: Codable {
    
    var artistName: String
    var collectionName: String
    var trackName: String
    
    init(artistName: String, collectionName: String, trackName: String) {
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
    }
    
}
