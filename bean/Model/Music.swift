//
//  MusicSearchResultModel.swift
//  bean
//
//  Created by dewey seo on 24/06/2021.
//

import Foundation

struct Music: Codable {
    var wrapperType: String
    var kind: String
    var trackName: String
    var artistName: String
    var collectionName: String
    var previewUrl: String
    var artistId: Int
    var collectionId: Int
    var trackId: Int
    var artworkUrl30: String?
    var artworkUrl60: String?
    var artworkUrl100: String?
    
    var thumbnail: String {
        get {
            return self.artworkUrl100 ?? artworkUrl60 ?? artworkUrl30 ?? ""
        }
    }
}

struct MusicSearchResult: Codable {
    var resultCount: Int
    var results: [Music]?
}
