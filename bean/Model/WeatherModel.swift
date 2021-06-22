//
//  WeatherModel.swift
//  bean
//
//  Created by dewey seo on 19/06/2021.
//

struct WeatherModel: Decodable {
    var base: String?
}

//http://api.openweathermap.org/data/2.5/weather?appid=15538a4f5c1c8a3cacf36711ebf67dd5&lat=10.778724&lon=106.746692

//{
//    "coord": {
//        "lon": 106.7467,
//        "lat": 10.7787
//    },
//    "weather": [
//    {
//    "id": 803,
//    "main": "Clouds",
//    "description": "broken clouds",
//    "icon": "04d"
//    }
//    ],
//    "base": "stations",
//    "main": {
//        "temp": 302.21,
//        "feels_like": 309.21,
//        "temp_min": 302.21,
//        "temp_max": 302.21,
//        "pressure": 1009,
//        "humidity": 89
//    },
//    "visibility": 10000,
//    "wind": {
//        "speed": 3.09,
//        "deg": 240
//    },
//    "clouds": {
//        "all": 75
//    },
//    "dt": 1624325424,
//    "sys": {
//        "type": 1,
//        "id": 9314,
//        "country": "VN",
//        "sunrise": 1624314738,
//        "sunset": 1624360654
//    },
//    "timezone": 25200,
//    "id": 1566083,
//    "name": "Ho Chi Minh City",
//    "cod": 200
//}
