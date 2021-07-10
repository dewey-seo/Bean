//
//  DataManager.swift
//  bean
//
//  Created by dewey seo on 10/07/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DataManager {
    
    var feed: [Post]? {
        didSet {
            obaservableFeed.onNext(feed ?? [])
        }
    }
    
    var obaservableFeed = BehaviorSubject<[Post]>(value: [])
    
    static let shared = DataManager()
}
