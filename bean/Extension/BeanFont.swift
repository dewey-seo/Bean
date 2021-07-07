//
//  BeanFont.swift
//  bean
//
//  Created by dewey seo on 06/07/2021.
//

import UIKit

extension UIFont {
    static var title1: UIFont {
        return UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    static var title1Bold: UIFont {
        return UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    static var title2: UIFont {
        return UIFont.systemFont(ofSize: 21, weight: .regular)
    }
    static var title2Bold: UIFont {
        return UIFont.systemFont(ofSize: 21, weight: .bold)
    }
    static var title3: UIFont {
        return UIFont.systemFont(ofSize: 19, weight: .regular)
    }
    static var title3Bold: UIFont {
        return UIFont.systemFont(ofSize: 19, weight: .bold)
    }
    static var title4: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    static var title4Bold: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    static var headline1: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    static var headline1Bold: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    static var body1: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    static var body1Bold: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    static var body1Itaic: UIFont {
        return UIFont.italicSystemFont(ofSize: 15)
    }
    static var caption1: UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    static var caption1Bold: UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .bold)
    }
    static var caption2: UIFont {
        return UIFont.systemFont(ofSize: 11, weight: .regular)
    }
    static var caption2Bold: UIFont {
        return UIFont.systemFont(ofSize: 11, weight: .bold)
    }
}

extension UIFont {
    static var bottomButton: UIFont { return UIFont.headline1Bold }
}
