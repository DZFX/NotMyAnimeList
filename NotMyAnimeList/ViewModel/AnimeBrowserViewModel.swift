//
//  AnimeBrowserViewModel.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit

typealias AnimeData = [(genre: String, animeList: [Anime])]

class AnimeBrowserViewModel: NSObject {

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
}
