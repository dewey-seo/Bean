//
//  BeanDate.swift
//  bean
//
//  Created by dewey seo on 09/07/2021.
//

import UIKit

enum DateFormatType {
    case aaa
    var format: String {
        switch self {
        default:
            return "dd/MM/yyyy HH:mm:ss"
        }
    }
}

extension Date {
    func getCurrentDate(_ type: DateFormatType = .aaa) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.format
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: Date())
    }
}
