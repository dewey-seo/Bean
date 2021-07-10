//
//  AppCoordinator.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit
import RxSwift
import FirebaseAuth

class AppCoordinator: Coordinator{
    var children = [Coordinator]()
    var router: Router
    
    let window: UIWindow
    let rootVC: RootViewController = RootViewController.init(nibName: "RootViewController", bundle: nil)
    
    let disposeBag: DisposeBag = DisposeBag()
    
    public init(window: UIWindow) {
        console("init - AppCoordinator")
        self.window = window
        self.router = Router(fromViewController: nil)
        
        router.navigationController.viewControllers = [rootVC]
        router.navigationController.setNavigationBarHidden(true, animated: false)
        router.navigationController.modalPresentationStyle = .fullScreen
    }
    
    deinit {
        console("deinit - AppCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
        
        observingIsLogin()
    }
    
    func observingIsLogin() {
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
            let coordinator = MainCoordinator(from: self.router)
            presentChild(coordinator, animated: true)
        } else {
            let coordinator = SignInCoordinator(from: self.router)
            presentChild(coordinator, animated: true)
        }
    }
    
    func findParent<T: Coordinator>(_ type: T.Type) -> T? {
        return nil
    }
}
