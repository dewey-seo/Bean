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
    
    lazy var loginVC: LoginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
    lazy var signUpVC: SignUpViewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)

    init(from: Router?) {
        self.router = Router.init(fromViewController: from?.navigationController)
        router.navigationController.modalPresentationStyle = .fullScreen
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
        signUpVC.firebaseUser = firebaseUser
        signUpVC.delegate = self
        router.push(signUpVC, animated: true)
    }
}

// MARK: - SignUpViewControllerDelegate
extension SignInCoordinator: SignUpViewControllerDelegate {
    func didFinishSignUp(user: User) {
        RealmManager.shared.saveUser(user: user)
    }
}
