//
//  PodcastListViewModel.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation
import UIKit

class PodcastListViewModel {
    
    var podcastViewModels: [PodcastViewModel] = [PodcastViewModel]()
    var webService: WebService<PodcastList>
    var completion: () -> Void
    
    init(webService: WebService<PodcastList>, completion: @escaping () -> Void) {
        self.webService = webService
        self.completion = completion
        self.populatePodcasts()
    }
    
    private func populatePodcasts() {
        webService.downloadData { success, podcastList in
            let podcasts = podcastList?.results ?? []
            self.podcastViewModels = podcasts.map(PodcastViewModel.init)
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }
    
    func podcastViewModel(at index: Int) -> PodcastViewModel {
        return podcastViewModels[index]
    }
    
}
