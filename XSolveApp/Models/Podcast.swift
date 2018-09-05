//
//  Podcast.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

class Podcast: Codable {
    
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var previewUrl: String?
    var artworkUrl60: String?
    var artworkUrl100: String?
    var trackPrice: Double?
    var currency: String?
    
    init(artistName: String?, collectionName: String?, trackName: String?, previewUrl: String?, artworkUrl60: String?, artworkUrl100: String?, trackPrice: Double?, currency: String?) {
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.previewUrl = previewUrl
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl100
        self.trackPrice = trackPrice
        self.currency = currency
    }
    
}
