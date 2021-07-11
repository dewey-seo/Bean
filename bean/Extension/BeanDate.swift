//
//  BeanDate.swift
//  bean
//
//  Created by dewey seo on 09/07/2021.
//

import UIKit

enum DateFormatType {
    case post
    var format: String {
        switch self {
        case .post:
            return "dd/MM/yyyy HH:mm:ss"
        default:
            return "dd/MM/yyyy HH:mm:ss"
        }
    }
}

extension Date {
    func formattedString(_ type: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.format
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: Date())
    }
}
