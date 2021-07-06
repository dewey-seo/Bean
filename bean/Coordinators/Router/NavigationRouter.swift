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
    
    weak var fromViewController: UIViewController?
    
    public init(navigationController: UINavigationController, fromViewController: UIViewController?) {
        self.navigationController = navigationController
        self.routerRootController = navigationController.viewControllers.first
        self.fromViewController = fromViewController
        super.init()
    }
}

extension NavigationRouter: Router {
    public func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let from = fromViewController else { return }
        navigationController.viewControllers = [viewController]
        from.present(navigationController, animated: true, completion: completion)
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
