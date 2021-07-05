//
//  SignInCoordinator.swift
//  bean
//
//  Created by dewey seo on 04/07/2021.
//

import UIKit
import FirebaseAuth

class SignInCoordinator: NSObject, Coordinator {
    weak var parent: Coordinator?
    var children = [Coordinator]()
    var router: Router
    var user: FirebaseAuth.User?
    
    var loginVC: LoginViewController

    init(router: Router, user: FirebaseAuth.User? = nil) {
        console("init - SignInCoordinator")
        self.router = router
        self.user = user
        self.loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
    }
    
    deinit {
        console("deinit - SignInCoordinator")
    }
    
    func start(animated: Bool, parent: Coordinator?) {
        router.present(loginVC, animated: true)
    }
}
