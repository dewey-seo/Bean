//
//  WeatherModel.swift
//  bean
//
//  Created by dewey seo on 19/06/2021.
//
// http://api.openweathermap.org/data/2.5/weather?appid=15538a4f5c1c8a3cacf36711ebf67dd5&lat=10.778724&lon=106.746692

import UIKit

class Coordinate: Codable {
    var longitude: Double
    var latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

class WeatherDisplay: Codable {
    var title: String
    var description: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case title = "main"
        case description
        case icon
    }
}

class WeatherDetail: Codable {
    var temperature: Double
    var humidity: Int
    var feelLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
        case feelLike = "feels_like"
    }
}

class WeatherWind: Codable {
    var speed: Double?
    var deg: Int?
}

class Weather: Codable {
    var coordinate: Coordinate
    var display: [WeatherDisplay]
    var detail: WeatherDetail
    var wind: WeatherWind
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "coord"
        case display = "weather"
        case detail = "main"
        case wind
        case name
    }
    
    var weatherIcon: String {
        get {
            let scale = Int(UIScreen.main.scale)
            return "http://openweathermap.org/img/wn/" + (display.first?.icon ?? "") + "@\(scale)x" + ".png"
        }
    }
}
