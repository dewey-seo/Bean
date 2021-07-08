//
//  MyTabCoordinator.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit

class MyTabCoordinator: NSObject, Coordinator {
    weak var parent: Coordinator?
    var children = [Coordinator]()
    var router: Router
    
    // MARK: -
    init(router: Router) {
        console("init - MyTabCoordinator")
        self.router = router
    }
    
    deinit {
        console("deinit - MyTabCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        self.parent = parent
    }
}
