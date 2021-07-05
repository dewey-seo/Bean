//
//  Router.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

public protocol Router {
    var onDismiss: (() -> Void)? { get set }
    
    // When Start Coordinator, should be called.
    func present(_ viewController: UIViewController, animated: Bool)
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    // Only use inside coordinator
    func push(_ viewController: UIViewController, animated: Bool)
    
    // Weh Close Coordinator, should be called.
    func dismiss(animated: Bool)
    func dismiss(animated: Bool, completion:(() -> Void)?)
}

extension Router {
    public func present(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated, completion: nil)
    }
    
    public func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
}

