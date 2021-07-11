//
//  BeanButton.swift
//  bean
//
//  Created by dewey seo on 02/07/2021.
//

import UIKit

extension UIButton {
    func setIsEnabled(_ isEnabled: Bool, withColor color: UIColor) {
        self.isEnabled = isEnabled
        self.backgroundColor = color
    }
    func setStyle(bgColor: UIColor, title: String, font: UIFont, titleColor: UIColor, radius: CGFloat? = 1) {
        self.backgroundColor = bgColor
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.roundCorenrs(8)
        
    }
}
