//
//  BeanColor.swift
//  bean
//
//  Created by dewey seo on 02/07/2021.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hex >> 16) & 0xFF), green: CGFloat((hex >> 8) & 0xFF), blue: CGFloat(hex & 0xFF), alpha: alpha)
    }
    
    static func buttonColor(withIsEnabled isEnabled: Bool) -> UIColor {
        return isEnabled ? UIColor.enabledButton : UIColor.disabledButton
    }
    
    static var enabledButton: UIColor {
        return .blue
    }
    static var disabledButton: UIColor {
        return .gray
    }
    open class var gray2: UIColor {
        get {
            return .gray
        }
    }
}
