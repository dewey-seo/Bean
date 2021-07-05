//
//  HomeCoordinator.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

class HomeTabCoordinator: NSObject, Coordinator {
    weak var parent: Coordinator?
    var children = [Coordinator]()
    var router: Router
    
    // MARK: -
    init(router: Router) {
        console("init - HomeTabCoordinator")
        self.router = router
    }
    
    deinit {
        console("deinit - HomeTabCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        self.parent = parent
    }
}
