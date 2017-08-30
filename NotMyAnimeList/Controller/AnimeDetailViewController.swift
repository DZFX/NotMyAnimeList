//
//  AnimeDetailViewController.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/30/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit
import AlamofireImage


class AnimeDetailViewController: UITableViewController {

    let animeDetailViewModel = AnimeDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.animeDetailViewModel.downloadData()
    }
    
    private func setup() {
        self.animeDetailViewModel.delegate = self
    }
    
    func reloadContent() {
        self.title = self.animeDetailViewModel.anime?.titleEnglish
        self.tableView.tableHeaderView = self.animeDetailViewModel.imageViewWithAnimeBanner()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of row
        if section == 0 {
            return 1
        }
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.animeDetailViewModel.tableView(tableView, infoCellForRowAt: indexPath) 
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.animeDetailViewModel.tableView(tableView, infoHeighForRowAt: indexPath)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AnimeDetailViewController: AnimeDetailViewModelDelegate {
    func animeDetailViewModelDidFinishDownloadingDetals(animeDetailViewModel: AnimeDetailViewModel) {
        self.reloadContent()
    }
}
