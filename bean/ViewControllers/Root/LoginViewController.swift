//
//  LoginViewController.swift
//  bean
//
//  Created by dewey seo on 16/06/2021.
//

import UIKit
import Firebase
import GoogleSignIn
import AuthenticationServices

public protocol LoginViewControllerDelegate: AnyObject {
    func registerUser(with firebaseUser: FirebaseAuth.User?)
}

class LoginViewController: UIViewController {
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var appleSignInButton: UIButton!
    
    weak var delegate: LoginViewControllerDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        setSubviews()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func onFinishedLoginToFirebase(user: FirebaseAuth.User?) {
        guard let user = user else {
            console("ERROR in onFinishedLoginToFirebase")
            return
        }
        
        UserService.shared.getUser(user) { [weak self] registeredUser in
            if let registeredUser = registeredUser {
                RealmManager.shared.saveUser(user: registeredUser)
            } else {
                self?.delegate?.registerUser(with: user)
            }
        }
    }
    
    @IBAction func googleSignInPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func appleSignInPressed(_ sender: Any) {
        let authorizationController = AuthManager.shared.startSignInWithAppleFlow(from: self)
        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func setSubviews() {
        view.backgroundColor = .primary6
        
        googleSignInButton.setStyle(
            bgColor: .white,
            title: "Sing in with Google",
            font: .title4Bold,
            titleColor: .primary6,
            radius: 8
        )
        appleSignInButton.setStyle(
            bgColor: .grey9,
            title: "Sing in with Apple",
            font: .title4Bold,
            titleColor: .white,
            radius: 8
        )
        googleSignInButton.setImage(UIImage(named: "login_btn_google"), for: .normal)
        appleSignInButton.setImage(UIImage(named: "login_btn_apple"), for: .normal)
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

extension LoginViewController: ASAuthorizationControllerDelegate {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//
//    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = AuthManager.shared.currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.            
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            AuthManager.shared.finishedAppleSignIn(with: credential) { [weak self] user in
                self?.onFinishedLoginToFirebase(user: user)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
    }
}
