//
//  BeanImageView.swift
//  bean
//
//  Created by dewey seo on 09/07/2021.
//

import UIKit

extension UIImageView {
    convenience init(name: String) {
        let image = UIImage(named: name)
        self.init(image: image)
    }
}
