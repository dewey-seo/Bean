//
//  BeanColor.swift
//  bean
//
//  Created by dewey seo on 02/07/2021.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        self.init(red: 255, green: 255, blue: 255, alpha: 0)
    }
}

extension UIColor {
    static var grey1: UIColor { return UIColor(hex: "#F6F6F6FF") }
    static var grey2: UIColor { return UIColor(hex: "#EAEAEAFF") }
    static var grey3: UIColor { return UIColor(hex: "#DADADAFF") }
    static var grey4: UIColor { return UIColor(hex: "#C0C0C0FF") }
    static var grey5: UIColor { return UIColor(hex: "#9D9D9DFF") }
    static var grey6: UIColor { return UIColor(hex: "#7C7C7CFF") }
    static var grey7: UIColor { return UIColor(hex: "#616161FF") }
    static var grey8: UIColor { return UIColor(hex: "#3E3E3EFF") }
    static var grey9: UIColor { return UIColor(hex: "#1D1D1DFF") }
    static var black: UIColor { return UIColor(hex: "#000000FF") }
}

extension UIColor {
    static var primary1: UIColor { return UIColor(hex: "#FFF8E8FF") }
    static var primary2: UIColor { return UIColor(hex: "#FFE9B1FF") }
    static var primary3: UIColor { return UIColor(hex: "#FFCC7EFF") }
    static var primary4: UIColor { return UIColor(hex: "#FFA34EFF") }
    static var primary5: UIColor { return UIColor(hex: "#F6742AFF") }
    static var primary6: UIColor { return UIColor(hex: "#F5520CFF") }
    static var primary7: UIColor { return UIColor(hex: "#E14B0BFF") }
    static var primary8: UIColor { return UIColor(hex: "#C53B10FF") }
    static var primary9: UIColor { return UIColor(hex: "#A7270BFF") }
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
