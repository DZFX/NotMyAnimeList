//
//  BrowseRequest.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit
import ObjectMapper

enum BrowseRequestSeason: String {
    case Spring = "spring"
    case Summer = "summer"
    case Fall = "fall"
    case Winter = "winter"
}

class BrowseRequest: NSObject {

    var year: Int?
    var season: BrowseRequestSeason?
    var type: String?
    var status: String?
    var genres: String?
    var genresExclude: String?
    var sort: String?
    var airingData: String?
    var fullPage: String?
    var page: Int?
    
    convenience required init?(map: Map) {
        self.init()
    }
}

extension BrowseRequest: Mappable {
    func mapping(map: Map) {
        self.year <- map["year"]
        self.season <- (map["season"], EnumTransform<BrowseRequestSeason>())
        self.type <- map["type"]
        self.status <- map["status"]
        self.genres <- map["genres"]
        self.genresExclude <- map["genres_exclude"]
        self.sort <- map["sort"]
        self.airingData <- map["airing_data"]
        self.fullPage <- map["full_page"]
        self.page <- map["page"]
    }
}
