//
//  AnimeBrowserViewModel.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

typealias AnimeGenre = (genre: Genre, animeList: [Anime])
typealias AnimeData = [AnimeGenre]

protocol AnimeBrowserViewModelDelegate: class {
    func animeBrowserViewModelFinishedFetchingGenreList(animeBrowserViewModel: AnimeBrowserViewModel)
    func animeBrowserViewModel(animeBrowserViewModel: AnimeBrowserViewModel, didFinishLoadingGenreAtIndex index: Int)
}

class AnimeBrowserViewModel: NSObject {

    weak var delegate: AnimeBrowserViewModelDelegate?
    
    var animeData: AnimeData = AnimeData()
    
    var numberOfGenres: Int {
        return self.animeData.count
    }
    
    func animeItemsInSection(_ section: Int) -> Int {
        return self.animeData[section].animeList.count
    }
    
    func genreInSection(_ section: Int) -> String {
        return self.animeData[section].genre.genre ?? ""
    }
    
    func retrieveGenres() {
        Genre.fetchGenreList { (genreList, error) in
            if let _genreList = genreList {
                self.animeData = _genreList.map({ (genre) -> AnimeGenre in
                    return (genre: genre, animeList: [])
                })
                self.delegate?.animeBrowserViewModelFinishedFetchingGenreList(animeBrowserViewModel: self)
            }
        }
    }
    
    func retrieveLists() {
        for (index, animeGenre) in self.animeData.enumerated() {
            let browseRequest = BrowseRequest()
            browseRequest.genres = animeGenre.genre.genre
            browseRequest.status = "Currently Airing"
            browseRequest.fullPage = "true"
            Anime.browseMedia(browseRequest: browseRequest) { (animeList, error) in
                if let _animeList = animeList {
                    self.animeData[index].animeList = _animeList
                    self.delegate?.animeBrowserViewModel(animeBrowserViewModel: self, didFinishLoadingGenreAtIndex: index)
                }
            }
        }
    }
    
    func sectionedCollectionView(collectionView: SectionedCollectionView, animeCellForRowAtIndexPath indexPath: IndexPath) -> AnimeCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimeCell", for: indexPath) as? AnimeCell {
            cell.name = self.animeData[indexPath.section].animeList[indexPath.item].titleEnglish
            return cell
        }
        return AnimeCell()
    }
}
