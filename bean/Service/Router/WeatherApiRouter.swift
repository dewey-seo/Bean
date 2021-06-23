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
    
    var parameters: Parameters? {
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
        let request = try URLRequest(url: url, method: method, headers: headers)
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}


