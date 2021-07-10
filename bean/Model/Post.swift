//
//  PostModel.swift
//  bean
//
//  Created by dewey seo on 29/06/2021.
//

import Foundation

enum PostType: String, Codable {
    case unknown = "unknown"
    case place = "place"
    case photo = "photo"
    case video = "video"
    case music = "music"
    case book = "book"
    case movie = "movie"
    case tv = "tv"
    case sticker = "sticker"
    case weather = "weather"
    case thought = "thought"
    case workout = "workout"
    case nikefuel = "nikefuel"
    case advertise = "advertise"
    case inhouse = "inhouse"
}

enum PostError: Error {
    case convertError
    case unknownTypeError
}

class Post: Codable {
    var id: String
    var customId: String
    var postType: PostType
    var createdAt: Date
    
    var music: Music?
    var photo: Photo?
    var weather: Weather?
    
    init(type: PostType, data: Any) {
        self.id = UUID().uuidString
        self.customId = id
        self.postType = type
        self.createdAt = Date()
        
        switch type {
        case .music:
            guard let music = data as? Music else { return }
            self.music = music
        case .photo:
            guard let photo = data as? Photo else { return }
            self.photo = photo
        case .weather:
            guard let weather = data as? Weather else { return }
            self.weather = weather
        default:
            return
        }
    }
}
