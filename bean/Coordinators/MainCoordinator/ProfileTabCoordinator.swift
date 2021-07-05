//
//  ProfileTabCoordinator.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

class ProfileTabCoordinator: NSObject, Coordinator {
    weak var parent: Coordinator?
    var children = [Coordinator]()
    var router: Router
    
    // MARK: -
    init(router: Router) {
        self.router = router
    }
    
    func present(animated: Bool, parent: Coordinator?, onDismissed: (() -> Void)?) {
        self.parent = parent
    }
}
