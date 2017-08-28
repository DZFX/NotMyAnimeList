//
//  APIServices.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class APIServices: APIAuthentication {

    public enum ServiceEndpoints {
        case GenreList()
        
        public var method: HTTPMethod {
            switch self {
            case .GenreList:
                return HTTPMethod.get
            }
        }
        
        public var path: String {
            switch self {
            case .GenreList:
                return baseURL + "/genre_list"
            }
        }
        
        public var parameters: [String: Any] {
            switch self {
            case .GenreList:
                return ["access_token": Session.current.accessToken ?? ""]
            }
        }
    }
    
    static func request(_ endpoint: ServiceEndpoints) -> DataRequest {
        return Alamofire.request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters, encoding: URLEncoding.default, headers: nil)
    }
}
