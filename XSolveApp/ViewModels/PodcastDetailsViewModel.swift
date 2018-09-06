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
    
    //MARK: Properties
    private var podcastViewModel: PodcastViewModel
    private var musicDownloader: MusicDownloader = MusicDownloader()
    var musicButton: MusicButton?
    
    var musicState: MusicState = .none {
        didSet {
            musicButton?.musicState = musicState
        }
    }
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(pauseMusic), name: .AVPlayerItemDidPlayToEndTime , object: musicDownloader.player)
    }
    
    //MARK: Image loading method
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        ImageDownloader.downloadImage(from: podcastViewModel.artworkUrl100, completion: completion)
    }
    
    //MARK: Music management methods
    func downloadMusic() {
        self.musicState = .downloading
        guard let previewUrl = podcastViewModel.previewUrl else { return }
        let musicUrl = URL(string: previewUrl)!
        musicDownloader.downloadFileFromURL(url: musicUrl) { [weak self] url in
            DispatchQueue.main.async {
                self?.musicState = .paused
            }
        }
    }
    
    func toggleMusic() {
        switch self.musicState {
        case .playing:
            self.pauseMusic()
        case .paused:
            self.playMusic()
        default:
            return
        }
    }
    
    private func playMusic() {
        self.musicDownloader.playMusic()
        self.musicState = .playing
    }
    
    @objc private func pauseMusic() {
        self.musicDownloader.pauseMusic()
        self.musicState = .paused
    }
    
}
