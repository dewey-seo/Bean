//
//  PostingPlaceCoordinator.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

class PostingPlaceCoordinator: NSObject, Coordinator {
    weak var parent: Coordinator?
    var children = [Coordinator]()
    var router: Router
    
    lazy var postingVC: PostingPlaceViewController = PostingPlaceViewController(nibName: "PostingPlaceViewController", bundle: nil)
    
    // MARK: -
    init(from: Router?) {
        console("init - PostingPlaceCoordinator")
        self.router = Router.init(fromViewController: from?.navigationController)
    }
    deinit {
        console("deinit - PostingPlaceCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        self.parent = parent
        router.present(postingVC, animated: true)
        postingVC.delegate = self
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

extension PostingPlaceCoordinator: PostingPlaceViewControllerDelegate {
    func didFinishedPosting() {
        
    }
    
    func cancelPosting() {
        router.dismiss(animated: true)
    }
}
