//
//  Anime+Networking.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
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
    
    func downloadFullDetail(completion: @escaping (_ anime: Anime?, _ error: Error?) -> ()) {
        APIServices.request(APIServices.ServiceEndpoints.Series(self, "anime")).responseObject { (response: DataResponse<Anime>) in
            if let _error = response.error {
                completion(nil, _error)
            } else {
                if let _anime = response.value {
                    self.updateData(anime: _anime)
                    do {
                        completion(try Realm().object(ofType: Anime.self, forPrimaryKey: self.ID), nil)
                    } catch let error {
                        completion(nil, error)
                    }
                }
            }
        }
    }
    
    func downloadImage(completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        APIServices.request(APIServices.ServiceEndpoints.ImageDownload(self.imageURL ?? "")).responseImage { (response: DataResponse<Image>) in
            if let _error = response.error {
                completion(nil, _error)
            } else {
                if let _image = response.value {
                    self.saveImage(image: _image)
                    completion(_image, nil)
                } else {
                    completion(nil, NSError(domain: "Anime.image", code: 0, userInfo: [NSLocalizedDescriptionKey: "Parsing Error"]))
                }
            }
        }
    }
    
    private func updateData(anime: Anime) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(anime, update: true)
            }
        } catch let error {
            print("ERROR: - There was a problem while trying to update Anime object")
            print(error.localizedDescription)
        }
    }
    
    private func saveImage(image: UIImage) {
        do {
            let realm = try Realm()
            try realm.write {
                self.image = image
                realm.add(self, update: true)
            }
        } catch let error {
            print("ERROR: - There was a problem while trying to persist Anime.image data")
            print(error.localizedDescription)
        }
    }
}
