//
//  BeanDictionary.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import Foundation

extension Dictionary {
    mutating func merge<K, V>(dictionaries: Dictionary<K, V>...) {
        for dict in dictionaries {
            for (key, value) in dict {
                self.updateValue(value as! Value, forKey: key as! Key)
            }
        }
    }
}
