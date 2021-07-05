//
//  AppCoordinator.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit
import RxSwift
import FirebaseAuth

class AppCoordinator: Coordinator {
    var children = [Coordinator]()
    var router: Router
    
    let window: UIWindow
    let navC: UINavigationController
    let rootVC: RootViewController
    
    let disposeBag: DisposeBag = DisposeBag()
    
    public init(window: UIWindow) {
        self.window = window
        self.rootVC = RootViewController.init(nibName: "RootViewController", bundle: nil)
        self.navC = UINavigationController(rootViewController: rootVC)
        self.navC.modalPresentationStyle = .fullScreen
        self.router = NavigationRouter(navigationController: self.navC)
        
        navC.setNavigationBarHidden(true, animated: false)
    }
    
    deinit {
        console("deinit - AppCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        window.rootViewController = navC
        window.makeKeyAndVisible()
        
        ovserveLoginStatusChange()
    }
    
    func ovserveLoginStatusChange() {
        AuthManager.shared.user.subscribe(onNext: { [weak self] firebaseUser in
            if let firebaseUser = firebaseUser {
                UserService.shared.getUser(firebaseUser) { user in
                    guard let _ = user else {
                        self?.onChangeLoginStatus(status: .Register(user: firebaseUser))
                        return
                    }
                    self?.onChangeLoginStatus(status: .Login)
                }
            } else {
                self?.onChangeLoginStatus(status: .Logout)
            }
        })
        .disposed(by: disposeBag)
    }
    
    func onChangeLoginStatus(status: AuthStatus) {
        if let child = children.first {
            child.close(animated: true)
        }
        
        switch status {
        case .Login:
            let coordinator = MainCoordinator(router: router)
            presentChild(coordinator, animated: true)
        case .Logout:
            let coordinator = SignInCoordinator(router: router)
            presentChild(coordinator, animated: true)
        case .Register(let user):
            let coordinator = SignInCoordinator(router: router, user: user)
            presentChild(coordinator, animated: true)
        }
    }
}
