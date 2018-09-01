//
//  PodcastFeed.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 01.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

class PodcastFeed: Feed {
    
    private var termToSearch: String = ""
    
    init(termToSearch: String) {
        self.termToSearch = termToSearch.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
    }
    
    var base: String {
        return "https://itunes.apple.com"
    }
    
    var path: String {
        return "/search?term=\(termToSearch)"
    }
    
    func getURL() -> URL {
        return URL(string: base+path)!
    }
    
}
