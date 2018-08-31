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
        registerCells()
        self.podcastListViewModel = PodcastListViewModel() {
            self.tableView.reloadData()
        }
    }
    
    func registerCells() {
        let podcastCellNib = UINib(nibName: "PodcastTableViewCell", bundle: nil)
        tableView.register(podcastCellNib, forCellReuseIdentifier: "PodcastTableViewCell")
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
        cell.trackNameLabel.text = podcastListViewModel.podcastViewModels[indexPath.row].trackName
        return cell
    }

}
