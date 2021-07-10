//
//  PostingPhotoCoordinator.swift
//  bean
//
//  Created by dewey seo on 07/07/2021.
//

import UIKit

class PostingPhotoCoordinator: NSObject, Coordinator {
    weak var parent: Coordinator?
    var children = [Coordinator]()
    var router: Router
    var presetImage: UIImage?
    
    lazy var postingVC: PostingPhotoViewController = PostingPhotoViewController(nibName: "PostingPhotoViewController", bundle: nil)
    
    // MARK: -
    init(from: Router?) {
        console("init - PostingPhotoCoordinator")
        self.router = Router.init(fromViewController: from?.navigationController)
    }
    deinit {
        console("deinit - PostingPhotoCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        self.parent = parent
        router.present(postingVC, animated: true)
        postingVC.delegate = self
        postingVC.presetImage = presetImage
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

extension PostingPhotoCoordinator: PostingPhotoViewControllerDelegate {
    func didFinishedPosting() {
        if let coordinator = self.findParent(HomeTabCoordinator.self) {
            coordinator.reloadFeed()
        }
        self.router.dismiss(animated: true)
    }
    
    func cancelPosting() {
        router.dismiss(animated: true)
    }
    
}
