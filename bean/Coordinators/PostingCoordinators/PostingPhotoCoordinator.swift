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
}

extension PostingPhotoCoordinator: PostingPhotoViewControllerDelegate {
    func didFinishedPosting() {
        
    }
    
    func cancelPosting() {
        router.dismiss(animated: true)
    }
    
}
