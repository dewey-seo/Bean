//
//  WeatherModel.swift
//  bean
//
//  Created by dewey seo on 19/06/2021.
//

//import ObjectMapper
//
//struct WeatherCoordinate: Mappable {
//    let latitude: Float?
//    let longitude: Float?
//    
//    init?(map: Map) {
//        latitude <- map["lat"]
//        longitude <- map["lon"]
//    }
//    
//    mutating func mapping(map: Map) {}
//}
//
//struct WeatherInfo {
//    let id: Int
//    let title: String
//    let description: String
//    let icon: String
//    
//    init?(map: Map) {
//        id <- map["id"]
//        title <- map["main"]
//        description <- map["description"]
//        icon <- map["icon"]
//    }
//    
//    mutating func mapping(map: Map) {}
//}
//
//struct WeatherDetail {
//    let temp: Float
//    let feels: Float
//    let minTemp: Float
//    let maxTemp: Float
//    let pressure: Int
//    let humidity: Int
//}
//
//struct WeatherWind {
//    let speed: Float
//    let deg: Int
//}
//
struct WeatherModel: Decodable {
    var base: String?
//    let coordinate: WeatherCoordinate?
//    let weather: WeatherInfo?
//    let detailInfo: WeatherDetail
//    let wind: WeatherWind
//
//    init?(map: Map) {
//        id      =  map["id"]
//        coordinate = WeatherCoordinate(map: map["coord"])
//        weather = WeatherInfo(map: map["weather"])
//    }
}

