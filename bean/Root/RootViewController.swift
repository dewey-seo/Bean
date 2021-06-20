//
//  RootViewController.swift
//  bean
//
//  Created by dewey seo on 16/06/2021.
//

import UIKit
import RxSwift

class RootViewController: UIViewController {
    
    let disposeBag: DisposeBag = DisposeBag()
    var loginVC: LoginViewController?
    var mainVC: MainViewController?
    
    var isMounted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.isMounted == false) {
            AuthManager.shared.isLogin()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: switchViewController)
                .disposed(by: disposeBag)
        }
        
        self.isMounted = true
    }
    
    func switchViewController(_ isLogin: Bool) {
        isLogin ? showMainViewController() : showLoginViewController()
    }
    
    func showLoginViewController() {
        loginVC?.dismiss(animated: true, completion: nil)
        mainVC?.dismiss(animated: true, completion: nil)
        
        loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        if let loginVC = loginVC {
            let navC = UINavigationController.init(rootViewController: loginVC)
            navC.modalPresentationStyle = .fullScreen
            self.present(navC, animated: true, completion: nil)
        }
    }
    
    func showMainViewController() {
        loginVC?.dismiss(animated: true, completion: nil)
        mainVC?.dismiss(animated: true, completion: nil)
        mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        if let mainVC = mainVC {
            let navC = UINavigationController.init(rootViewController: mainVC)
            navC.modalPresentationStyle = .fullScreen
            self.present(navC, animated: true, completion: nil)
        }
    }
}
