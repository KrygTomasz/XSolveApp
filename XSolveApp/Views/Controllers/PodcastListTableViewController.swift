//
//  PodcastListTableViewController.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit
import UIEmptyState

class PodcastListTableViewController: UITableViewController {
    
    private var webService: WebService<PodcastList>!
    private var podcastFeed: PodcastFeed!
    private var podcastListViewModel: PodcastListViewModel!
    private var dataSource: TableViewDataSource<PodcastTableViewCell, PodcastViewModel>!
    private var podcastCellIdentifier: String = "PodcastTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationBar(withTitle: "podcasts".localized())
        prepareTableView()
        self.podcastFeed = PodcastFeed(termToSearch: "Jack johnson")
        self.webService = WebService<PodcastList>(feed: podcastFeed)
        self.podcastListViewModel = PodcastListViewModel(webService: self.webService) {
            self.prepareDataSource()
        }
    }
    
    private func prepareTableView() {
        registerCells()
        self.emptyStateDelegate = self
        self.emptyStateDataSource = self
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .backgroundColor
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 4, 0)
    }
    
    private func registerCells() {
        let podcastCellNib = UINib(nibName: podcastCellIdentifier, bundle: nil)
        tableView.register(podcastCellNib, forCellReuseIdentifier: podcastCellIdentifier)
        let headerNib = UINib(nibName: "SearchListHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "SearchListHeader")
    }
    
    private func prepareDataSource() {
        self.dataSource = TableViewDataSource(cellIdentifier: self.podcastCellIdentifier, viewModels: self.podcastListViewModel.podcastViewModels, configureCell: self.configureCell)
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
        self.reloadEmptyStateForTableView(self.tableView)
    }
    
    private func configureCell(_ cell: PodcastTableViewCell, using viewModel: PodcastViewModel) {
        cell.trackNameLabel.text = viewModel.trackName
        cell.artistNameLabel.text = viewModel.artistName
        viewModel.loadImage() { image in
            DispatchQueue.main.async {
                cell.coverImageView.image = image
            }
        }
    }
    
    private func goToPodcastDetails(using podcastViewModel: PodcastViewModel) {
        let podcastDetailsViewModel = PodcastDetailsViewModel(using: podcastViewModel)
        let vc = PodcastDetailsViewController.getInstance(using: podcastDetailsViewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: UITableViewDelegate
extension PodcastListTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchListHeader") as? SearchListHeader else { return UIView() }
        header.delegate = self
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = podcastListViewModel.podcastViewModel(at: indexPath.row)
        goToPodcastDetails(using: model)
    }
    
}

//MARK: SearchListHeaderDelegate
extension PodcastListTableViewController: SearchListHeaderDelegate {
    
    func search(text: String) {
        self.podcastFeed = PodcastFeed(termToSearch: text)
        self.webService = WebService<PodcastList>(feed: podcastFeed)
        self.podcastListViewModel = PodcastListViewModel(webService: self.webService) {
            self.prepareDataSource()
        }
    }
    
}

//MARK: UIEmptyStateDelegates
extension PodcastListTableViewController: UIEmptyStateDelegate, UIEmptyStateDataSource {
    var emptyStateTitle: NSAttributedString {
        return NSAttributedString(string: podcastListViewModel.emptyViewMessage, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    var emptyStateImage: UIImage? {
        let image = #imageLiteral(resourceName: "podcastIcon").withRenderingMode(.alwaysTemplate)
        return image
    }
    var emptyStateImageViewTintColor: UIColor? {
        return UIColor.white
    }
}
