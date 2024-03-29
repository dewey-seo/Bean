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
    
    lazy var loginVC: LoginViewController = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
    lazy var signUpVC: SignUpViewController = SignUpViewController.init(nibName: "SignUpViewController", bundle: nil)

    init(from: Router?) {
        self.router = Router.init(fromViewController: from?.navigationController)
        router.navigationController.modalPresentationStyle = .fullScreen
    }
    
    deinit {
        console("deinit - SignInCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        loginVC.delegate = self
        router.present(loginVC, animated: true, withCloseButton: false)
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
