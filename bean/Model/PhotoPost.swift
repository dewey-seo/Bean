//
//  PhotoModel.swift
//  bean
//
//  Created by dewey seo on 29/06/2021.
//

import UIKit

class PhotoPost: PostModel {
    var id: String
    var customId: String
    var postType: PostType
    var createdAt: Date
    var photoUrlString: String
    var previewImageData: Data?
    var comment: String
    
    init(type: PostType, photoUrl: URL, comment: String, previewImageData: Data? = nil) {
        self.id = UUID().uuidString
        self.customId = id
        self.postType = type
        self.createdAt = Date()
        self.photoUrlString = photoUrl.absoluteString
        self.previewImageData = previewImageData
        self.comment = comment
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case customId
        case postType
        case createdAt
        case photoUrlString
        case previewImageData
        case comment
    }
}
