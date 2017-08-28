//
//  APIAuthentication.swift
//  NotMyAnimeList
//
//  Created by Isaac Delgado on 8/28/17.
//  Copyright © 2017 Isaac Delgado. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import AeroGearHttp
import AeroGearOAuth2

class APIAuthentication: APIBase {

    var http: Http?
    var accessToken: String?
    var expireDate: Date?
    
    public enum Endpoints {
        case AccessToken(AccessTokenRequest)
        
        public var method: HTTPMethod {
            switch self {
            case .AccessToken:
                return HTTPMethod.post
            }
        }
        
        public var path: String {
            switch self {
            case .AccessToken:
                return baseURL + "/auth/access_token"
            }
        }
        
        public var parameters: [String: Any] {
            switch self {
            case .AccessToken(let request):
                return request.toJSON()
            }
        }
    }
    
    override init() {
        super.init()
        self.http = Http()
    }

    func requestAuthentication() {
//        let config = Config(base: "https://anilist.co/api", authzEndpoint: "/auth", redirectURL: "org.isaacdelgado.NotAnimeList:", accessTokenEndpoint: "/auth/access_token", clientId: "dzfx-9vvne")
//        let gdModule = AccountManager.addAccountWith(config: config, moduleClass: OAuth2Module.self)
//        self.http?.authzModule = gdModule
        
        self.http?.request(method: HttpMethod.post, path: "https://anilist.co/api/auth/access_token", parameters: ["grant_type" : "client_credentials", "client_id" : "dzfx-9vvne", "client_secret" : "rWwLz4ZXTkrARrDIV7FSxJvCvgQ4X"], credential: nil, responseSerializer: StringResponseSerializer(), completionHandler: { (response, error) in
            if error != nil {
                NotificationCenter.default.post(name: NSNotification.Name("AccessTokenFailed"), object: nil)
            } else {
                
            }
            print(response as Any)
            print(error?.localizedDescription ?? "No error")
        })
    }
    
    static func requestToken(request: AccessTokenRequest) -> DataRequest {
        let endpoint = Endpoints.AccessToken(request)
        return Alamofire.request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters, encoding: URLEncoding.default, headers: nil)
    }
}
