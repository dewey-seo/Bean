//
//  Common.swift
//  bean
//
//  Created by dewey seo on 05/07/2021.
//

import Foundation

public func console(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    let prefix = "🚀> "
    let output = items.map { "\($0)" }.joined(separator: separator)
    Swift.print(prefix + output, terminator: terminator)
}

