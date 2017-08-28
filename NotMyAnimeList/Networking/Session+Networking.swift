//
//  Session+Networking.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

extension Session {
    static func grantCredentials(accessTokenRequest: AccessTokenRequest, completion: @escaping (_ result: Session?, _ error: Error?) -> ()) {
        APIAuthentication.requestToken(request: accessTokenRequest).responseObject { (response: DataResponse<Session>) in
            if let _error = response.error {
                completion(nil, _error)
            } else {
                if let _sessionData = response.value {
                    self.saveSessionData(sessionData: _sessionData)
                    completion(_sessionData, nil)
                } else {
                    completion(nil, NSError(domain: "Session.grantCredentials", code: 0, userInfo: [NSLocalizedDescriptionKey:"Parsing Error"]))
                }
            }
        }
    }
    
    static func saveSessionData(sessionData: Session) {
        Session.current = sessionData
    }
}
