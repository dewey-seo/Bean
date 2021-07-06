//
//  SignInCoordinator.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit
import Firebase
//import FirebaseAuth

class SignInCoordinator: NSObject, Coordinator {
    weak var parent: Coordinator?
    var children = [Coordinator]()
    var router: Router
    var user: FirebaseAuth.User?
    
    lazy var loginVC: LoginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
    lazy var signUpVC: SignUpViewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)

    init(router: Router, user: FirebaseAuth.User? = nil) {
        console("init - SignInCoordinator")
        self.router = router
        self.user = user
    }
    
    deinit {
        console("deinit - SignInCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        loginVC.delegate = self
        router.present(loginVC, animated: true)
    }
}

// MARK: - LoginViewControllerDelegate
extension SignInCoordinator: LoginViewControllerDelegate {
    func registerUser(with firebaseUser: FirebaseAuth.User?) {
        router.push(signUpVC, animated: true)
    }
}
