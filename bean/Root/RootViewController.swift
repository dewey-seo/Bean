//
//  RootViewController.swift
//  bean
//
//  Created by dewey seo on 16/06/2021.
//

import UIKit
import RxSwift
import FirebaseAuth

class RootViewController: UIViewController {
    
    let disposeBag: DisposeBag = DisposeBag()
    var loginVC: LoginViewController?
    var mainVC: MainViewController?
    var signUpVC: SignUpViewController?
    
    var isMounted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.isMounted == false) {
            AuthManager.shared.user.subscribe(onNext: { [weak self] firebaseUser in
                if let firebaseUser = firebaseUser {
                    UserService.shared.getUser(firebaseUser) { user in
                        guard let _ = user else {
                            self?.switchViewController(status: .Register(user: firebaseUser))
                            return
                        }
                        self?.switchViewController(status: .Login)
                    }
                } else {
                    self?.switchViewController(status: .Logout)
                }
            })
            .disposed(by: disposeBag)
        }
        
        self.isMounted = true
    }
    
    func switchViewController(status: AuthStatus) {
        switch(status) {
        case .Login:
            showMainViewController()
        case .Logout:
            showLoginViewController()
        case .Register(let user):
            showSignUpViewController(user)
        }
    }
    
    func showLoginViewController() {
        loginVC?.dismiss(animated: true, completion: nil)
        mainVC?.dismiss(animated: true, completion: nil)
        signUpVC?.dismiss(animated: true, completion: nil)
        
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
        signUpVC?.dismiss(animated: true, completion: nil)
        
        mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        
        if let mainVC = mainVC {
            let navC = UINavigationController.init(rootViewController: mainVC)
            navC.modalPresentationStyle = .fullScreen
            self.present(navC, animated: true, completion: nil)
        }
    }
    
    func showSignUpViewController(_ user: FirebaseAuth.User) {
        loginVC?.dismiss(animated: true, completion: nil)
        mainVC?.dismiss(animated: true, completion: nil)
        signUpVC?.dismiss(animated: true, completion: nil)
        
        signUpVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        signUpVC?.user = User(user: user)
        
        if let signUpVC = signUpVC {
            let navC = UINavigationController.init(rootViewController: signUpVC)
            navC.modalPresentationStyle = .fullScreen
            self.present(navC, animated: true, completion: nil)
        }
    }
}
