//
//  WebService.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

class WebService<Model: Codable> {
    
    typealias WebSericeDownloadDataCompletion = (WSResult<Model, WSError>) -> Void
    
    private var feed: Feed
    
    init(feed: Feed) {
        self.feed = feed
    }
    
    func downloadData(completion: @escaping WebSericeDownloadDataCompletion) {
        guard let url = feed.getURL() else {
            completion(WSResult.failure(.wrongUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(WSResult.failure(.serviceError))
                return
            }
            guard let data = data else {
                completion(WSResult.failure(.invalidData))
                return
            }
            do {
                let model = try JSONDecoder().decode(Model.self, from: data)
                completion(WSResult.success(model))
                return
            } catch let jsonError {
                NSLog(jsonError.localizedDescription)
                completion(WSResult.failure(.jsonDecodingFailure))
                return
            }
        }.resume()
    }
    
}
