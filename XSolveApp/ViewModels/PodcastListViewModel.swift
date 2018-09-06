//
//  PodcastListViewModel.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation
import UIKit

enum PodcastEmptyViewState {
    case firstLaunch
    case noData
    case failure(WSError)
}

class PodcastListViewModel {
    
    var podcastViewModels: [PodcastViewModel] = [PodcastViewModel]()
    var webService: WebService<PodcastList>
    var completion: () -> Void
    var emptyViewMessage: String {
        switch emptyViewState {
        case .firstLaunch:
            return ""
        case .noData:
            return "noPodcasts".localized()
        case .failure(let error):
            print(error.localizedDescription)
            return error.localizedDescription
        }
    }
    private var emptyViewState: PodcastEmptyViewState = .firstLaunch
    
    init(webService: WebService<PodcastList>, completion: @escaping () -> Void) {
        self.webService = webService
        self.completion = completion
        self.populatePodcasts()
    }
    
    private func populatePodcasts() {
        ProgressHUD.shared.showActivityIndicator(title: "\("searching".localized())...")
        webService.downloadData { result in
            switch result {
            case .failure(let error):
                self.emptyViewState = .failure(error)
                self.podcastViewModels = []
                DispatchQueue.main.async {
                    self.completion()
                    ProgressHUD.shared.hideActivityIndicator()
                }
            case .success(let podcastList):
                self.emptyViewState = .noData
                let podcasts = podcastList.results
                self.podcastViewModels = podcasts.map(PodcastViewModel.init)
                DispatchQueue.main.async {
                    self.completion()
                    ProgressHUD.shared.hideActivityIndicator()
                }
            }
        }
    }
    
    func podcastViewModel(at index: Int) -> PodcastViewModel {
        return podcastViewModels[index]
    }
    
}
