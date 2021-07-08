//
//  BeanTabbar.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

class BeanTabbar: UITabBar {
    override func layoutSubviews() {
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view
    }
}
