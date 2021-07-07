//
//  Router.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

enum RouterType {
    case base
}

public class Router: NSObject {
    public let navigationController: UINavigationController
    public var onDismiss: (() -> Void)?
    
    weak var fromViewController: UIViewController?
    
    init(fromViewController: UIViewController?) {
        self.navigationController = UINavigationController()
        self.fromViewController = fromViewController
    }
}

extension Router {
    func present(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated, completion: nil)
    }
    
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let from = fromViewController else { return }
        navigationController.viewControllers = [viewController]
        from.present(navigationController, animated: true, completion: completion)
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
    func dismiss(animated: Bool, completion:(() -> Void)?) {
        onDismiss?()
        navigationController.dismiss(animated: animated, completion: completion)
    }
}

// MARK: - UINavigationControllerDelegate
extension Router: UINavigationControllerDelegate {
}
