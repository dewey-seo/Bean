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
    init(from: Router?) {
        console("init - NAMECoordinator")
        self.router = Router.init(fromViewController: from?.navigationController)
    }
    deinit {
        console("deinit - NAMECoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        self.parent = parent
    }
    
    func findParent<T: Coordinator>(_ type: T.Type) -> T? {
        guard let parent = self.parent else {
            return nil
        }
        if let parent = parent as? T {
            return parent
        } else {
            return parent.findParent(type)
        }
    }
}

