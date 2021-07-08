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
    
    lazy var postingVC: PostingThoughtViewController = PostingThoughtViewController.loadFromNib()
    
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
}

extension PostingThoughtCoordinator: PostingThoughtViewControllerDelegate {
    func didFinishedPosting() {
        
    }
    
    func cancelPosting() {
        router.dismiss(animated: true)
    }
}

