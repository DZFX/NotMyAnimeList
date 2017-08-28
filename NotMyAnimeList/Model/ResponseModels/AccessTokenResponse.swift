//
//  AccessTokenResponse.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit
import ObjectMapper

class AccessTokenResponse: NSObject {

    var accessToken: String?
    var expiresIn: Int?
    
    convenience required init?(map: Map) {
        self.init()
    }
}

extension AccessTokenResponse: Mappable {
    func mapping(map: Map) {
        self.accessToken <- map["access_token"]
        self.expiresIn <- map["expires_in"]
    }
}
