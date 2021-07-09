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
    var navigationController: UINavigationController
    var onDismiss: (() -> Void)?
    
    weak var fromViewController: UIViewController?
    
    init(fromViewController: UIViewController?) {
        self.navigationController = UINavigationController()
        self.fromViewController = fromViewController
    }
}

extension Router {
    func present(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated, completion: nil)
        addCloseButton(to: viewController)
    }
    
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let from = fromViewController else { return }
        navigationController.viewControllers = [viewController]
        from.present(navigationController, animated: true, completion: completion)
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
        addBackButton(to: viewController)
    }
    
    func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
    func dismiss(animated: Bool, completion:(() -> Void)?) {
        onDismiss?()
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    private func addCloseButton(to viewController: UIViewController) {
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem("nav_close", target: self, action: #selector(closePressed), for: .touchUpInside)
    }
    private func addBackButton(to viewController: UIViewController) {
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem("nav_back", target: self, action: #selector(backPressed), for: .touchUpInside)
    }
    
    @objc private func backPressed() {
        self.navigationController.popViewController(animated: true)
    }
    @objc private func closePressed() {
        self.dismiss(animated: true)
    }
}

// MARK: - UINavigationControllerDelegate
extension Router: UINavigationControllerDelegate {
}
