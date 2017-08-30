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
        self.setup()
        
        Session.grantCredentials(accessTokenRequest: AccessTokenRequest.defaultRequest) { (session, error) in
            if session != nil {
                print("Success")
                
                self.animeBrowserViewModel.retrieveGenres()
            }
        }
    }
    
    private func setup() {
        self.animeBrowserCollectionView.sectionedDataSource = self
        self.animeBrowserCollectionView.sectionedDelegate = self
        self.animeBrowserViewModel.delegate = self
    }
}

extension AnimeBrowserViewController: SectionedCollectionViewDataSource {
    func numberOfSections(_ collectionView: SectionedCollectionView) -> Int {
        return self.animeBrowserViewModel.numberOfGenres
    }
    
    func sectionedCollectionView(_ collectionView: SectionedCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.animeBrowserViewModel.animeItemsInSection(section)
    }
    
    func sectionedCollectionView(_ collectionView: SectionedCollectionView, titleForSection section: Int) -> String? {
        return self.animeBrowserViewModel.genreInSection(section)
    }
    
    func sectionedCollectionView(_ collectionView: SectionedCollectionView, rowCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.animeBrowserViewModel.sectionedCollectionView(collectionView: collectionView, animeCellForRowAtIndexPath: indexPath)
    }
}

extension AnimeBrowserViewController: SectionedCollectionViewDelegate {
    func sectionedCollectionView(_ collectionView: SectionedCollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.animeBrowserViewModel.animeTitleAt(indexPath: indexPath))
    }
}

extension AnimeBrowserViewController: AnimeBrowserViewModelDelegate {
    func animeBrowserViewModelFinishedFetchingGenreList(animeBrowserViewModel: AnimeBrowserViewModel) {
        self.animeBrowserCollectionView.reloadData()
        self.animeBrowserViewModel.retrieveLists()
    }
    
    func animeBrowserViewModel(animeBrowserViewModel: AnimeBrowserViewModel, didFinishLoadingGenreAtIndex index: Int) {
        self.animeBrowserCollectionView.reloadSections([index])
    }
}

