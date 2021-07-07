//
//  BeanEncodable.swift
//  bean
//
//  Created by dewey seo on 03/07/2021.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    func asDictionary(_ other: [String: Any]? = nil) -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        var result = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
        if let other = other {
            result?.merge(dictionaries: other)
        }
        return result
    }
}
