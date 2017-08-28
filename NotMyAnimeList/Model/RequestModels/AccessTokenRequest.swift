//
//  AccessTokenRequest.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit
import ObjectMapper

class AccessTokenRequest: NSObject {

    static let defaultRequest = AccessTokenRequest()
    
    var grantType = "client_credentials"
    var clientID = "dzfx-9vvne"
    var clientSecret = "rWwLz4ZXTkrARrDIV7FSxJvCvgQ4X"
    
    convenience required init?(map: Map) {
        self.init()
    }
}

extension AccessTokenRequest: Mappable {
    func mapping(map: Map) {
        self.grantType <- map["grant_type"]
        self.clientID <- map["client_id"]
        self.clientSecret <- map["client_secret"]
    }
}
