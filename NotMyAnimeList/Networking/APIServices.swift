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
        case ImageDownload(String)
        case GenreList
        case Browse(BrowseRequest, String)
        case Series(Anime, String)
        
        public var method: HTTPMethod {
            switch self {
            case .ImageDownload:
                return HTTPMethod.get
            case .GenreList:
                return HTTPMethod.get
            case .Browse:
                return HTTPMethod.get
            case .Series:
                return HTTPMethod.get
            }
        }
        
        public var path: String {
            switch self {
            case .ImageDownload(let url):
                return url
            case .GenreList:
                return baseURL + "/genre_list"
            case .Browse(_, let type):
                return baseURL + "/browse/\(type)"
            case .Series(let anime, let type):
                return baseURL + "/\(type)/\(anime.ID!)/page"
            }
        }
        
        public var parameters: [String: Any] {
            switch self {
            case .ImageDownload(_):
                return [:]
            case .GenreList:
                return ["access_token": Session.current.accessToken ?? ""]
            case .Browse(let request, _):
                var jsonDict = request.toJSON()
                jsonDict["access_token"] = Session.current.accessToken ?? ""
                return jsonDict
            case .Series(_, _):
                return ["access_token": Session.current.accessToken ?? ""]
            }
        }
    }
    
    static func request(_ endpoint: ServiceEndpoints) -> DataRequest {
        return Alamofire.request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters, encoding: URLEncoding.default, headers: nil)
    }
    
    static func download(_ endpoint: ServiceEndpoints, to destination: @escaping DownloadRequest.DownloadFileDestination) -> DownloadRequest {
        return Alamofire.download(endpoint.path, method: endpoint.method, parameters: endpoint.parameters, encoding: URLEncoding.default, headers: nil, to: destination)
    }
}
