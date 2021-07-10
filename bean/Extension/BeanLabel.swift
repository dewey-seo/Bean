//
//  BeanLabel.swift
//  bean
//
//  Created by dewey seo on 10/07/2021.
//

import UIKit

extension UILabel {
    func setStyle(font: UIFont, color: UIColor, text: String? = nil) {
        self.font = font
        self.textColor = color
        if let text = text {
            self.text = text
        }
    }
}
