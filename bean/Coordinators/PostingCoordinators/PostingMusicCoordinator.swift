//
//  PostingMusicCoordinator.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

class PostingMusicCoordinator: NSObject, Coordinator {
    weak var parent: Coordinator?
    var children = [Coordinator]()
    var router: Router
    
    lazy var postingVC: PostingMusicViewController = PostingMusicViewController.loadFromNib()
    
    // MARK: -
    init(from: Router?) {
        console("init - PostingMusicCoordinator")
        self.router = Router.init(fromViewController: from?.navigationController)
    }
    deinit {
        console("deinit - PostingMusicCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        self.parent = parent
        router.present(postingVC, animated: true)
        postingVC.delegate = self
    }
}

extension PostingMusicCoordinator: PostingMusicViewControllerDelegate {
    func didFinishedPosting() {
        
    }
    
    func cancelPosting() {
        router.dismiss(animated: true)
    }
}
