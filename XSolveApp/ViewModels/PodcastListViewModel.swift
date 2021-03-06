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
    
    //MARK: Properties
    var podcastViewModels: [PodcastViewModel] = [PodcastViewModel]()
    var webService: WebService<PodcastList>?
    var completion: () -> Void
    var emptyViewMessage: String {
        switch emptyViewState {
        case .firstLaunch:
            return "firstLaunchInfo".localized()
        case .noData:
            return "noPodcasts".localized()
        case .failure(let error):
            return error.localizedDescription
        }
    }
    private var emptyViewState: PodcastEmptyViewState = .firstLaunch
    
    //MARK: Initializer
    init(webService: WebService<PodcastList>?, completion: @escaping () -> Void) {
        self.webService = webService
        self.completion = completion
        self.populatePodcasts()
    }
    
    //MARK: Podcasts management methods
    private func populatePodcasts() {
        guard let _ = webService else { return }
        ProgressHUD.shared.showActivityIndicator(title: "\("searching".localized())...")
        webService?.downloadData { result in
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
