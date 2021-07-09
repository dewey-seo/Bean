//
//  BeanBarButtonItem.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

extension UIBarButtonItem {
    convenience init(_ imageName: String, target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        let icon = UIImage(named: imageName)
        let button = UIButton.init(type: .custom)
        button.setImage(icon, for: .normal)
        button.addTarget(target, action: action, for: controlEvents)
        self.init(customView: button)
    }
}
