//
//  WeatherApiRequestType.swift
//  bean
//
//  Created by dewey seo on 19/06/2021.
//

import Foundation
import Alamofire
import CoreLocation

enum WeatherApiRouter {
    case getCurrentWeather(_ lat: String, _ lon: String)
}

extension WeatherApiRouter: ApiRouter {
    var baseUrlString: String {
        switch self {
        case .getCurrentWeather:
            return "http://api.openweathermap.org/data/2.5/"
        }
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather:
            return "weather"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCurrentWeather:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: tParameters? {
        var parameters = ["appid": KeyManager.shared.getWeatherApiId()]
        switch self {
        case .getCurrentWeather(let lat, let lon):
            parameters["lat"] = lat
            parameters["lon"] = lon
        }
        return parameters
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrlString.asURL().appendingPathComponent(path)
        var request = try URLRequest(url: url, method: method, headers: headers)
        
        if let params = parameters, params.count > 0 {
            switch method {
            case .get:
                request = try URLEncodedFormParameterEncoder().encode(params, into: request)
            case .post:
                request = try JSONParameterEncoder().encode(params, into: request)
            default:
                break
            }
        }
        
        return request
    }
    
}


