//
//  BeanArray.swift
//  bean
//
//  Created by dewey seo on 09/07/2021.
//

import Foundation

extension Array {
    func lastIndex() -> Int {
        return Swift.max(self.count - 1, 0)
    }
}
