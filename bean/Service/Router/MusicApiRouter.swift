//
//  MusicApiRouter.swift
//  bean
//
//  Created by dewey seo on 24/06/2021.
//

import Foundation
import Alamofire
import CoreLocation

enum MusicApiRouter {
    case searchMusic(_ keyword: String)
}

extension MusicApiRouter: ApiRouter {
    var baseUrlString: String {
        switch self {
        case .searchMusic:
            return "https://itunes.apple.com/"
        }
    }
    
    var path: String {
        switch self {
        case .searchMusic:
            return "search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchMusic:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        var parameters = Parameters()
        switch self {
        case .searchMusic(let keyword):
            parameters["attribute"] = "artistTerm"
            parameters["limit"] = 50
            parameters["term"] = keyword
        }
        return parameters
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrlString.asURL().appendingPathComponent(path)
        let request = try URLRequest(url: url, method: method, headers: headers)
        return try URLEncoding.default.encode(request, with: parameters)
    }
}



