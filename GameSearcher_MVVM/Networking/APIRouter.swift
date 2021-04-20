//
//  APIRouter.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 1/28/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import Alamofire

public enum APIRouter: URLRequestConvertible {
    
    enum Constants {
        static let baseUrl = "https://api.rawg.io/api"
        static let headers = "TestGameApp"
        static let APIKEY  = "37dab016729042a7a5b21a5d522d6e8c"
    }
    
    case searchGames(String, Int)
    case details(Int)
    case screenshots(String)
    case similar(Int, Int)
    case trailers(Int)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .searchGames:
            return "games"
        case .details(let id):
            return "games/\(id)"
        case .screenshots(let name):
            return "games/\(name)/screenshots"
        case .similar(_ , let id):
            return "games/\(id)/suggested"
        case .trailers(let id):
            return "games/\(id)/movies"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .searchGames(let text, let page):
            return [
                    "page_size" : 10,
                    "search"   : text,
                    "page"     : page
                    ]
        case .details:
            return [:]
        case .screenshots:
            return [:]
        case .similar(let page, _):
            return ["page" : page]
        case .trailers(_):
            return [:]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL().appendingPathComponent(path)
        
        var finalParams = parameters
        finalParams["key"] = Constants.APIKEY
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(Constants.headers, forHTTPHeaderField: "User-Agent")
        request.timeoutInterval = TimeInterval(10 * 1000)
        return try URLEncoding.queryString.encode(request, with: finalParams)
    }
}


