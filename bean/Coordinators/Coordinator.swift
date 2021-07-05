//
//  Coordinator.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var router: Router { get set }
    
    // Do not call directly.
    func start(animated: Bool, parent: Coordinator?)
    func close(animated: Bool)
    func presentChild(_ child: Coordinator, animated: Bool, onDismissed: (() -> Void)?)
}

// MARK: - Children manage - Coordinator life cycle control.
extension Coordinator {
    public func close(animated: Bool) {
        router.dismiss(animated: true)
    }
    
    public func presentChild(_ child: Coordinator, animated: Bool, onDismissed: (() -> Void)? = nil) {
        children.append(child)
        
        let inputOnDismissed = onDismissed
        let requiredDismissed = { [weak self, weak child] in
            guard let self = self, let child = child else { return }
            self.removeChild(child)
        }
        
        let mergedOnDismissed: (() -> Void)? = {
            inputOnDismissed?()
            requiredDismissed()
        }
        
        child.router.onDismiss = mergedOnDismissed
        child.start(animated: animated, parent: self)
    }
    
    private func removeChild(_ child: Coordinator) {
        guard let index = children.firstIndex(where: { $0 === child }) else { return }
        children.remove(at: index)
    }
}
