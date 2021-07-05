//
//  SignInManager.swift
//  bean
//
//  Created by dewey seo on 16/06/2021.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class SignInManager: NSObject {
    static let shared = SignInManager()
}

extension SignInManager: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error { return }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        AuthManager.shared.finishedGoogleSignIn(with: credential)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        console("log out")
    }
}
