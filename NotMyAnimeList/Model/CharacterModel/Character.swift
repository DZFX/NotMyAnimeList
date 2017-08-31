//
//  Character.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/30/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class Character: Object {

    dynamic var ID: String?
    dynamic var firstName: String?
    dynamic var lastName: String?
    dynamic var japaneseName: String?
    dynamic var imageURL: String?
    dynamic var role: String?
    dynamic var info: String?
    
    var image: UIImage?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String {
        return "ID"
    }
    
    override class func ignoredProperties() -> [String] {
        return ["image"]
    }
    
    fileprivate func transformOfInt() -> TransformOf<String, Int> {
        return TransformOf<String, Int>(fromJSON: { (integer: Int?) -> String? in
            return String(integer ?? 0)
        }, toJSON: { (string: String?) -> Int? in
            return Int(string ?? "")
        })
    }
    
    func fullName() -> String? {
        var finalName = String()
        if let _firstName = self.firstName {
            finalName.append(_firstName)
        }
        if let _lastName = self.lastName {
            if finalName.characters.count > 0 {
                finalName.append(" ")
            }
            finalName.append(_lastName)
        }
        return finalName
    }
}

extension Character: Mappable {
    func mapping(map: Map) {
        self.ID <- (map["id"], transformOfInt())
        self.firstName <- map["name_first"]
        self.lastName <- map["name_last"]
        self.imageURL <- map["image_url_lge"]
        self.role <- map["role"]
        
        self.japaneseName <- map["name_japanese"]
        self.info <- map["info"]
    }
}
