//
//  Genre.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class Genre: Object {

    dynamic var genre: String?
    dynamic var ID: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "ID"
    }
}

extension Genre: Mappable {
    func mapping(map: Map) {
        self.genre <- map["genre"]
        self.ID <- map["id"]
    }
}


