//
//  Anime+Networking.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RealmSwift

extension Anime {
    static func browseMedia(browseRequest: BrowseRequest, completion: @escaping (_ result: [Anime]?, _ error: Error?) -> ()) {
        APIServices.request(APIServices.ServiceEndpoints.Browse(browseRequest, "anime")).responseArray { (response: DataResponse<[Anime]>) in
            if let _error = response.error {
                completion(nil, _error)
            } else {
                if let _animeList = response.value {
                    persist(animeList: _animeList)
                    do {
                        let filteredArray = try Realm().objects(self).filter({ anime -> Bool in
                            return anime.genres.contains(browseRequest.genres ?? "")
                        })
                        completion(Array(filteredArray), nil)
                        
                    } catch let error {
                        completion(nil, error)
                    }
                    completion(_animeList, nil)
                }
            }
        }
    }
    
    func downloadImage() {
        
    }
    
    private static func persist(animeList: [Anime]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(animeList, update: true)
            }
        } catch let error {
            print("ERROR: - There was a problem while trying to persist [Anime] data")
            print(error.localizedDescription)
        }
    }
}
