//
//  Time.swift
//  bean
//
//  Created by dewey seo on 03/07/2021.
//

import Foundation
import UIKit

class Time {
    static var currentDateString: String {
        get {
            return String(Date().timeIntervalSince1970 * 1000000)
        }
    }
}
