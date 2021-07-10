//
//  FeedModel.swift
//  bean
//
//  Created by dewey seo on 29/06/2021.
//

import UIKit
import RealmSwift

class Feed {
    var posts: [Post] = []
    
    convenience init(posts: [Post]) {
        self.init()
        self.posts = posts
    }
}
