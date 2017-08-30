//
//  Anime.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/27/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class Anime: Object {

    dynamic var ID: String?
    dynamic var seriesType: String?
    dynamic var titleRomaji: String?
    dynamic var titleEnglish: String?
    dynamic var titleJapanese: String?
    dynamic var mediaType: String?
    dynamic var season: String?
    dynamic var seriesDescription: String?
    dynamic var averageScore: String?
    dynamic var imageURL: String?
    dynamic var image: UIImage?
    
    var totalEpisodes: Int?
    
    var genres: [String] {
        get {
            return _backingGenres.map{ $0.stringValue }
        }
        
        set {
            _backingGenres.removeAll()
            let realmStringArray = newValue.map { (string) -> RealmString in
                let realmString = RealmString()
                realmString.stringValue = string
                return realmString
            }
            _backingGenres.append(objectsIn: realmStringArray)
        }
    }
    
    let _backingGenres = List<RealmString>()
    
    convenience init(name: String) {
        self.init()
        self.titleEnglish = name
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String {
        return "ID"
    }
    
    override class func ignoredProperties() -> [String] {
        return ["genres"]
    }
    
    fileprivate func transformOfInt() -> TransformOf<String, Int> {
        return TransformOf<String, Int>(fromJSON: { (integer: Int?) -> String? in
            return String(integer ?? 0)
        }, toJSON: { (string: String?) -> Int? in
            return Int(string ?? "")
        })
    }
    
    fileprivate func transformOfDouble() -> TransformOf<String, Double> {
        return TransformOf<String, Double>(fromJSON: { (double: Double?) -> String? in
            return String(double ?? 0.0)
        }, toJSON: { (string: String?) -> Double? in
            return Double(string ?? "")
        })
    }
}

extension Anime: Mappable {
    func mapping(map: Map) {
        self.ID <- (map["id"], transformOfInt())
        self.seriesType <- map["series_type"]
        self.titleRomaji <- map["title_romaji"]
        self.titleEnglish <- map["title_english"]
        self.titleJapanese <- map["title_japanese"]
        self.mediaType <- map["type"]
        self.season <- (map["season"], transformOfInt())
        self.seriesDescription <- map["description"]
        self.genres <- map["genres"]
        self.averageScore <- (map["average_score"], transformOfDouble())
        self.imageURL <- map["image_url_med"]
        
        self.totalEpisodes <- map["total_episodes"]
    }
}
