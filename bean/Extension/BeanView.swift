//
//  BeanView.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

extension UIView {
    func x() -> CGFloat { return self.frame.origin.x }
    func y() -> CGFloat { return self.frame.origin.y }
}

extension UIView {
    func roundCorenrs(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
