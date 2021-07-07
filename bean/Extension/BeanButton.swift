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
}
