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
        guard let homeTabVC = self.router.navigationController.viewControllers.first as? HomeTabViewController else {
            return
        }
        homeTabVC.delegate = self
        self.reloadFeed()
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
    
    func reloadFeed() {
        PostService.shared.reloadFeed { isSuccess in
            console("feed reload done", isSuccess)
        }
    }
}

extension HomeTabCoordinator: HomeTabViewControllerDelegate {
    func onPressWirte(type: ChooserType) {
        var coordinator: Coordinator? = nil
        switch type {
        case .place:
            coordinator = PostingMusicCoordinator(from: self.router)
        case .music:
            coordinator = PostingMusicCoordinator(from: self.router)
        case .photo:
            coordinator = PostingPhotoCoordinator(from: self.router)
        case .thought:
            coordinator = PostingThoughtCoordinator(from: self.router)
        case .weather:
            coordinator = PostingWeatherCoordinator(from: self.router)
        }
        
        if let coordinator = coordinator {
            self.presentChild(coordinator, animated: true)
        }
    }
}

//extension HomeTabCoordinator: ImagePickerCoordinatorDelegate {
//    func didFinishPickingImage(_ image: UIImage, target: ImagePickerCoordinatorTarget) {
//        switch target {
//        case .posting:
//            let coordinator = PostingPhotoCoordinator(from: self.router)
//            self.presentChild(coordinator, animated: true)
//        default:
//            break
//        }
//    }
//
//    func pickerControllerDidCancel(_ target: ImagePickerCoordinatorTarget) {
//        self.router.navigationController.showAlert(message: "picker canceled")
//    }
//}
