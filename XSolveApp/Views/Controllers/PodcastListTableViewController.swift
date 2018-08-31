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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Podcasts"
        prepareTableView()
        self.podcastListViewModel = PodcastListViewModel() {
            self.tableView.reloadData()
        }
    }
    
    func prepareTableView() {
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .lightGray
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 4, 0)
        registerCells()
    }
    
    func registerCells() {
        let podcastCellNib = UINib(nibName: "PodcastTableViewCell", bundle: nil)
        tableView.register(podcastCellNib, forCellReuseIdentifier: "PodcastTableViewCell")
        let headerNib = UINib(nibName: "SearchListHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "SearchListHeader")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcastListViewModel.podcastViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastTableViewCell", for: indexPath) as? PodcastTableViewCell else {
            return UITableViewCell()
        }
        let podcastViewModel = podcastListViewModel.podcastViewModel(at: indexPath.row)
        cell.trackNameLabel.text = podcastViewModel.trackName
        cell.artistNameLabel.text = podcastViewModel.artistName
        return cell
    }
    
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
    
    private func goToPodcastDetails(using podcastViewModel: PodcastViewModel) {
        let vc = PodcastDetailsViewController.getInstance(using: podcastViewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
