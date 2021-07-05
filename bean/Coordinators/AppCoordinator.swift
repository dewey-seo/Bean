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
        self.router = NavigationRouter(navigationController: self.navC)
        
        navC.setNavigationBarHidden(true, animated: false)
    }
    
    func present(animated: Bool, parent: Coordinator?, onDismissed: (() -> Void)?) {
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
//        switch status {
//        case .Login:
//            let router = ModalNavigationRouter(parentViewController: viewController)
//            let coordinator = PetAppointmentBuilderCoordinator(router: router)
//            presentChild(<#T##child: Coordinator##Coordinator#>, animated: <#T##Bool#>)
//        case .Logout:
//        case .Register(let user)
//        }
    }
}
