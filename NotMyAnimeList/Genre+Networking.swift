//
//  Genre+Networking.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

extension Genre {
    static func fetchGenreList(completion: @escaping (_ result: [Genre]?, _ error: Error?) -> ()) {
        APIServices.request(APIServices.ServiceEndpoints.GenreList()).responseArray { (response: DataResponse<[Genre]>) in
            if let _error = response.error {
                completion(nil, _error)
            } else {
                if let _genreList = response.value {
                    completion(_genreList, nil)
                } else {
                    completion(nil, NSError(domain: "Genre List", code: 0, userInfo: [NSLocalizedDescriptionKey: "Parsing Error"]))
                }
            }
        }
    }
}
