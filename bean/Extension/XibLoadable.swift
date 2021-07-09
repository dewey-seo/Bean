//
//  XibLoadable.swift
//  bean
//
//  Created by chodongwon on 2021/07/09.
//

import Foundation
import UIKit

protocol XibLoadable {
    associatedtype ViewType
    static var nibName: String { get }
    static func loadFromNib() -> ViewType
}

extension XibLoadable {
    static var nibName: String {
        get {
            return String(describing: type(of: self))
        }
    }
}

extension XibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        let nib = UINib(nibName: self.nibName, bundle: Bundle(for: self))
        guard let customView = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            preconditionFailure("Couldn't load view from xib: \(self.nibName)")
        }
        return customView
    }
}

extension XibLoadable where Self: UIViewController {
    static func loadFromNib() -> Self {
        return self.init(nibName: self.nibName, bundle: nil)
    }
    
}
