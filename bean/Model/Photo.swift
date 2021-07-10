//
//  PhotoModel.swift
//  bean
//
//  Created by dewey seo on 29/06/2021.
//

import UIKit

class Photo: Codable {
    var photoUrlString: String
    var previewImageData: Data?
    var comment: String
    
    init(photoUrl: URL, comment: String, previewImageData: Data? = nil) {
        self.photoUrlString = photoUrl.absoluteString
        self.previewImageData = previewImageData
        self.comment = comment
    }
    
    enum CodingKeys: String, CodingKey {
        case photoUrlString
        case previewImageData
        case comment
    }
    
    var gsImage: UIImage? {
        if let data = previewImageData {
            return UIImage(data: data)
        }
        return nil
    }
}
