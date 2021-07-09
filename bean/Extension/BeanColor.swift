//
//  BeanColor.swift
//  bean
//
//  Created by dewey seo on 02/07/2021.
//

import UIKit

extension UIColor {
    convenience init(hex:String, alpha: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue: UInt32 = 10066329
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension UIColor {
    static var grey1: UIColor { return UIColor(hex: "#F6F6F6") }
    static var grey2: UIColor { return UIColor(hex: "#EAEAEA") }
    static var grey3: UIColor { return UIColor(hex: "#DADADA") }
    static var grey4: UIColor { return UIColor(hex: "#C0C0C0") }
    static var grey5: UIColor { return UIColor(hex: "#9D9D9D") }
    static var grey6: UIColor { return UIColor(hex: "#7C7C7C") }
    static var grey7: UIColor { return UIColor(hex: "#616161") }
    static var grey8: UIColor { return UIColor(hex: "#3E3E3E") }
    static var grey9: UIColor { return UIColor(hex: "#1D1D1D") }
    static var black: UIColor { return UIColor(hex: "#000000") }
}

extension UIColor {
    static var primary1: UIColor { return UIColor(hex: "#FFF8E8") }
    static var primary2: UIColor { return UIColor(hex: "#FFE9B1") }
    static var primary3: UIColor { return UIColor(hex: "#FFCC7E") }
    static var primary4: UIColor { return UIColor(hex: "#FFA34E") }
    static var primary5: UIColor { return UIColor(hex: "#F6742A") }
    static var primary6: UIColor { return UIColor(hex: "#F5520C") }
    static var primary7: UIColor { return UIColor(hex: "#E14B0B") }
    static var primary8: UIColor { return UIColor(hex: "#C53B10") }
    static var primary9: UIColor { return UIColor(hex: "#A7270B") }
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
