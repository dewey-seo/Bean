//
//  CopyCoordinator.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

class NAMECoordinator: NSObject, Coordinator {
    weak var parent: Coordinator?
    var children = [Coordinator]()
    var router: Router
    
    // MARK: -
    init(router: Router) {
        self.router = router
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        self.parent = parent
    }
}

