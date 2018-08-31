//
//  WebServiceManager.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

typealias PodcastCompletion = (Bool, [Podcast]) -> Void

final class WebServiceManager {
    
    static var shared = WebServiceManager()
    private var podcastURL = URL(string: "https://itunes.apple.com/search?term=jack+johnson")!
    
    private init() { }
    
    func downloadPodcasts(completion: @escaping PodcastCompletion) {
        URLSession.shared.dataTask(with: podcastURL) { data, response, error in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(false, [])
            }
            guard let data = data else {
                completion(false, [])
                return
            }
            do {
                let podcastList = try JSONDecoder().decode(PodcastList.self, from: data)
                completion(true, podcastList.results)
            } catch let jsonError {
                NSLog(jsonError.localizedDescription)
                completion(false, [])
            }
        }.resume()
    }
    
}
