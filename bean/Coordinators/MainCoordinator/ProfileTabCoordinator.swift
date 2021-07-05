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
        console("init - ProfileTabCoordinator")
        self.router = router
    }
    
    deinit {
        console("deinit - ProfileTabCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        self.parent = parent
    }
}
