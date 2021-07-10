//
//  PostingThoughtCoordinator.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

class PostingThoughtCoordinator: NSObject, Coordinator {
    weak var parent: Coordinator?
    var children = [Coordinator]()
    var router: Router
    
    lazy var postingVC: PostingThoughtViewController = PostingThoughtViewController(nibName: "PostingThoughtViewController", bundle: nil)
    
    // MARK: -
    init(from: Router?) {
        console("init - PostingThoughtCoordinator")
        self.router = Router.init(fromViewController: from?.navigationController)
    }
    deinit {
        console("deinit - PostingThoughtCoordinator")
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

extension PostingThoughtCoordinator: PostingThoughtViewControllerDelegate {
    func didFinishedPosting() {
        
    }
    
    func cancelPosting() {
        router.dismiss(animated: true)
    }
}

