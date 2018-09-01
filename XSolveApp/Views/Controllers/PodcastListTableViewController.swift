//
//  PodcastListTableViewController.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 31.08.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

class PodcastListTableViewController: UITableViewController {
    
    private var podcastListViewModel: PodcastListViewModel!
    private var dataSource: TableViewDataSource<PodcastTableViewCell, PodcastViewModel>!
    private var podcastCellIdentifier: String = "PodcastTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Podcasts"
        prepareTableView()
        self.podcastListViewModel = PodcastListViewModel() {
            self.prepareDataSource()
        }
    }
    
    private func prepareTableView() {
        registerCells()
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .lightGray
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
    }
    
    private func configureCell(_ cell: PodcastTableViewCell, using viewModel: PodcastViewModel) {
        cell.trackNameLabel.text = viewModel.trackName
        cell.artistNameLabel.text = viewModel.artistName
    }
    
    private func goToPodcastDetails(using podcastViewModel: PodcastViewModel) {
        let vc = PodcastDetailsViewController.getInstance(using: podcastViewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: UITableViewDelegate
extension PodcastListTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchListHeader") as? SearchListHeader else { return UIView() }
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
