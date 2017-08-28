//
//  AnimeBrowserViewModel.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

typealias AnimeGenre = (genre: String, animeList: [Anime])
typealias AnimeData = [AnimeGenre]

protocol AnimeBrowserViewModelDelegate: class {
    func animeBrowserViewModelFinishedFetchingGenreList(animeBrowserViewModel: AnimeBrowserViewModel)
}

class AnimeBrowserViewModel: NSObject {

    weak var delegate: AnimeBrowserViewModelDelegate?
    
    var animeData: AnimeData = [
        (genre: "Action", animeList: [
            Anime(name: "Redline"),
            Anime(name: "Jojo's"),
            Anime(name: "Redline"),
            Anime(name: "Jojo's"),
            Anime(name: "Redline"),
            Anime(name: "Jojo's"),
            Anime(name: "Redline"),
            Anime(name: "Jojo's"),
            Anime(name: "Redline"),
            Anime(name: "Jojo's")
            ]),
        (genre: "Comedy", animeList: [
            Anime(name: "Samurai Shamploo"),
            Anime(name: "Great Teacher Onizuka"),
            Anime(name: "Samurai Shamploo"),
            Anime(name: "Great Teacher Onizuka"),
            Anime(name: "Samurai Shamploo"),
            Anime(name: "Great Teacher Onizuka"),
            Anime(name: "Samurai Shamploo"),
            Anime(name: "Great Teacher Onizuka"),
            Anime(name: "Samurai Shamploo"),
            Anime(name: "Great Teacher Onizuka")
            ]),
        (genre: "SciFi", animeList: [
            Anime(name: "Cowboy Bebop"),
            Anime(name: "Ghost in the Shell"),
            Anime(name: "Cowboy Bebop"),
            Anime(name: "Ghost in the Shell"),
            Anime(name: "Cowboy Bebop"),
            Anime(name: "Ghost in the Shell"),
            Anime(name: "Cowboy Bebop"),
            Anime(name: "Ghost in the Shell"),
            Anime(name: "Cowboy Bebop"),
            Anime(name: "Ghost in the Shell")
            ]),
        (genre: "Action", animeList: [
            Anime(name: "Redline"),
            Anime(name: "Jojo's"),
            Anime(name: "Redline"),
            Anime(name: "Jojo's"),
            Anime(name: "Redline"),
            Anime(name: "Jojo's"),
            Anime(name: "Redline"),
            Anime(name: "Jojo's"),
            Anime(name: "Redline"),
            Anime(name: "Jojo's")
            ]),
        (genre: "Comedy", animeList: [
            Anime(name: "Samurai Shamploo"),
            Anime(name: "Great Teacher Onizuka"),
            Anime(name: "Samurai Shamploo"),
            Anime(name: "Great Teacher Onizuka"),
            Anime(name: "Samurai Shamploo"),
            Anime(name: "Great Teacher Onizuka"),
            Anime(name: "Samurai Shamploo"),
            Anime(name: "Great Teacher Onizuka"),
            Anime(name: "Samurai Shamploo"),
            Anime(name: "Great Teacher Onizuka")
            ]),
        (genre: "SciFi", animeList: [
            Anime(name: "Cowboy Bebop"),
            Anime(name: "Ghost in the Shell"),
            Anime(name: "Cowboy Bebop"),
            Anime(name: "Ghost in the Shell"),
            Anime(name: "Cowboy Bebop"),
            Anime(name: "Ghost in the Shell"),
            Anime(name: "Cowboy Bebop"),
            Anime(name: "Ghost in the Shell"),
            Anime(name: "Cowboy Bebop"),
            Anime(name: "Ghost in the Shell")
            ])
    ]
    
    func retrieveGenres() {
        Genre.fetchGenreList { (genreList, error) in
            if let _genreList = genreList {
                self.animeData = _genreList.map({ (genre) -> AnimeGenre in
                    return (genre: genre.genre ?? "", animeList: [])
                })
                self.delegate?.animeBrowserViewModelFinishedFetchingGenreList(animeBrowserViewModel: self)
            }
        }
    }
}
