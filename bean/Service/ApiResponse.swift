//
//  ApiResponse.swift
//  bean
//
//  Created by dewey seo on 21/06/2021.
//

import Foundation

class ApiResponse<T: Decodable> {
    var data: T?
    
    init(_ data: T? = nil) {
        self.data = data
    }
}
