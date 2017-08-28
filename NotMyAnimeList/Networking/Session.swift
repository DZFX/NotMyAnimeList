//
//  Session.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit
import ObjectMapper

class Session: NSObject {

    static var current = Session()
    
    var accessToken: String?
    var expires: Int? {
        didSet {
            if let _expires = expires {
                self.expireDate = Date(timeIntervalSinceNow: TimeInterval(exactly: _expires)!)
            }
        }
    }
    var expireDate: Date?
    var hasExpired: Bool {
        return Date() > expireDate ?? Date(timeIntervalSinceReferenceDate: 0.0)
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
}

extension Session: Mappable {
    func mapping(map: Map) {
        self.accessToken <- map["access_token"]
        self.expires <- map["expires_in"]
    }
}
