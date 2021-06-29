//
//  PostModel.swift
//  bean
//
//  Created by dewey seo on 29/06/2021.
//

import Foundation

enum PostType: String, Codable {
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

class Post: Codable {
    var id: String?
    var type: PostType?
}
