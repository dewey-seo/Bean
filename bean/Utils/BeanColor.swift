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
}

extension UIColor {
    static var grey1: UIColor { return UIColor(hex: 0xF6F6F6) }
    static var grey2: UIColor { return UIColor(hex: 0xEAEAEA) }
    static var grey3: UIColor { return UIColor(hex: 0xDADADA) }
    static var grey4: UIColor { return UIColor(hex: 0xC0C0C0) }
    static var grey5: UIColor { return UIColor(hex: 0x9D9D9D) }
    static var grey6: UIColor { return UIColor(hex: 0x7C7C7C) }
    static var grey7: UIColor { return UIColor(hex: 0x616161) }
    static var grey8: UIColor { return UIColor(hex: 0x3E3E3E) }
    static var grey9: UIColor { return UIColor(hex: 0x1D1D1D) }
    static var black: UIColor { return UIColor(hex: 0x000000) }
}

extension UIColor {
    static var primary1: UIColor { return UIColor(hex: 0xFFF8E8) }
    static var primary2: UIColor { return UIColor(hex: 0xFFE9B1) }
    static var primary3: UIColor { return UIColor(hex: 0xFFCC7E) }
    static var primary4: UIColor { return UIColor(hex: 0xFFA34E) }
    static var primary5: UIColor { return UIColor(hex: 0xF6742A) }
    static var primary6: UIColor { return UIColor(hex: 0xF5520C) }
    static var primary7: UIColor { return UIColor(hex: 0xE14B0B) }
    static var primary8: UIColor { return UIColor(hex: 0xC53B10) }
    static var primary9: UIColor { return UIColor(hex: 0xA7270B) }
}

extension UIColor {
    static func buttonColor(withIsEnabled isEnabled: Bool) -> UIColor {
        return isEnabled ? UIColor.enabledButton : UIColor.disabledButton
    }
    
    static var enabledButton: UIColor {
        return .primary6
    }
    static var disabledButton: UIColor {
        return .grey3
    }
}
