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
        
        checkIsLogin()
    }
    
    func checkIsLogin() {
        RealmManager.shared.observeIsLogin()
            .subscribe { [weak self] isLogin in
                self?.onChangeLoginStatus(isLogin)
            }
            .disposed(by: disposeBag)
    }
    
    func onChangeLoginStatus(_ isLogin: Bool) {
        console("isLogin -> \(isLogin)")
        if let child = children.first {
            child.close(animated: true)
        }
        
        if(isLogin) {
            let coordinator = MainCoordinator(router: router)
            presentChild(coordinator, animated: true)
        } else {
            let coordinator = SignInCoordinator(router: router)
            presentChild(coordinator, animated: true)
        }
    }
}
