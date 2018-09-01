//
//  WebService.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

class WebService<Model: Codable> {
    
    private var feed: Feed
    
    init(feed: Feed) {
        self.feed = feed
    }
    
    func downloadData(completion: @escaping (Bool, Model?) -> Void) {
        print(feed.base + feed.path)
        URLSession.shared.dataTask(with: feed.getURL()) { data, response, error in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(false, nil)
            }
            guard let data = data else {
                completion(false, nil)
                return
            }
            do {
                let model = try JSONDecoder().decode(Model.self, from: data)
                completion(true, model)
            } catch let jsonError {
                NSLog(jsonError.localizedDescription)
                completion(false, nil)
            }
        }.resume()
    }
    
}
