//
//  KeyManager.swift
//  bean
//
//  Created by dewey seo on 19/06/2021.
//

import Foundation

class KeyManager {
    static let shared = KeyManager()
    var _keys: NSDictionary?
    var keys: NSDictionary? {
        get {
            if let keysDict = _keys {
                return keysDict
            }
            if let path = Bundle.main.path(forResource: "keys-Info", ofType: "plist") {
                return NSDictionary(contentsOfFile: path)
            }
            return nil
        }
    }
    
    func getWeatherApiId() -> String {
        return keys?.value(forKey: "OPEN_WEATHER_API_KEY") as? String ?? ""
    }
}
