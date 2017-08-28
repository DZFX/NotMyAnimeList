//
//  ViewController.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/26/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

class AnimeBrowserViewController: UICollectionViewController {

    let animeBrowserViewModel = AnimeBrowserViewModel()
    
    @IBOutlet weak var animeBrowserCollectionView: SectionedCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animeBrowserCollectionView.sectionedDataSource = self
        self.animeBrowserCollectionView.sectionedDelegate = self
        
        Session.grantCredentials(accessTokenRequest: AccessTokenRequest.defaultRequest) { (session, error) in
            if session != nil {
                print("Success")
                
            }
        }
    }


}

extension AnimeBrowserViewController: SectionedCollectionViewDataSource {
    func numberOfSections(_ collectionView: SectionedCollectionView) -> Int {
        return self.animeBrowserViewModel.animeData.count
    }
    
    func sectionedCollectionView(_ collectionView: SectionedCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.animeBrowserViewModel.animeData[section].animeList.count
    }
    
    func sectionedCollectionView(_ collectionView: SectionedCollectionView, titleForSection section: Int) -> String? {
        return self.animeBrowserViewModel.animeData[section].genre
    }
    
    func sectionedCollectionView(_ collectionView: SectionedCollectionView, rowCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimeCell", for: indexPath) as? AnimeCell {
            cell.name = self.animeBrowserViewModel.animeData[indexPath.section].animeList[indexPath.item].name
            return cell
        }
        return UICollectionViewCell()
    }
}

extension AnimeBrowserViewController: SectionedCollectionViewDelegate {
    
}



