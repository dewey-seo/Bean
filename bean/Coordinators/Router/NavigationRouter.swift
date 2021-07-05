//
//  NavigationRouter.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

public class NavigationRouter: NSObject {
    public let navigationController: UINavigationController
    public let routerRootController: UIViewController?
    public var onDismiss: (() -> Void)?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.routerRootController = navigationController.viewControllers.first
        super.init()
    }
}

extension NavigationRouter: Router {
    public func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    public func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    public func dismiss(animated: Bool, completion:(() -> Void)?) {
        self.onDismiss?()
        self.navigationController.dismiss(animated: animated, completion: completion)
    }
}

// MARK: - UINavigationControllerDelegate
extension NavigationRouter: UINavigationControllerDelegate {
}
