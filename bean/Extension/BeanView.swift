//
//  BeanView.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
    
    func x() -> CGFloat { return self.frame.origin.x }
    func y() -> CGFloat { return self.frame.origin.y }
}

extension UIView {
    func addBorderLine(width: CGFloat = 1, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func roundCorenrs(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func roundCorenrs(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func makeRounded() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height * 0.5
        clipsToBounds = true
    }
    
    func addShadow(cornerRadius: CGFloat = 16,
                   shadowColor: UIColor = UIColor(white: 0.0, alpha: 0.5),
                   shadowOffset: CGSize = CGSize(width: 0.0, height: 3.0),
                   shadowOpacity: Float = 0.3,
                   shadowRadius: CGFloat = 5) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
