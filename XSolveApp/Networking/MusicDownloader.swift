//
//  MusicDownloader.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 04.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation
import AVKit

enum MusicState {
    case downloading
    case paused
    case playing
    case none
}

class MusicDownloader {
    
    public private(set) var player: AVAudioPlayer?
    
    func downloadFileFromURL(url: URL, completion: @escaping (URL) -> Void){
        URLSession.shared.downloadTask(with: url, completionHandler: { url, response, error -> Void in
            guard let url = url else { return }
            self.preparePlayer(url: url)
            completion(url)
        }).resume()
    }
    
    func preparePlayer(url: URL) {
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.prepareToPlay()
            self.player?.volume = 1.0
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
    func playMusic() {
        self.player?.play()
    }
    
    func pauseMusic() {
        self.player?.pause()
    }
    
}
