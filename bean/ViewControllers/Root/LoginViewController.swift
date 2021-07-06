//
//  LoginViewController.swift
//  bean
//
//  Created by dewey seo on 16/06/2021.
//

import UIKit
import Firebase
import GoogleSignIn

public protocol LoginViewControllerDelegate: AnyObject {
    func registerUser(with firebaseUser: FirebaseAuth.User?)
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var googleSignInButton: UIButton!
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func onFinishedLoginToFirebase(user: FirebaseAuth.User?) {
        guard let user = user else { return }
        
        UserService.shared.getUser(user) { [weak self] registeredUser in
            if let registeredUser = registeredUser {
                RealmManager.shared.saveUser(user: registeredUser)
            } else {
                self?.delegate?.registerUser(with: user)
            }
        }
    }
    
    @IBAction func onPressGoogleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let _ = error { return }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        AuthManager.shared.finishedGoogleSignIn(with: credential) { [weak self] user in
            self?.onFinishedLoginToFirebase(user: user)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        console("log out")
    }
}
