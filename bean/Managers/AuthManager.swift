//
//  AuthManager.swift
//  bean
//
//  Created by dewey seo on 16/06/2021.
//

import UIKit
import RxSwift
import FirebaseAuth

class AuthManager: NSObject {
    static let shared = AuthManager()
    let firebaseAuth = Auth.auth()
    var user = BehaviorSubject<User?>(value: Auth.auth().currentUser)
    var userStateHandler: AuthStateDidChangeListenerHandle?

    override init() {
        super.init()
        userStateHandler = firebaseAuth.addStateDidChangeListener { [weak self] auth, user in
            self?.userStateChangeListener(auth, user)
        }
    }

    deinit {
        firebaseAuth.removeStateDidChangeListener(userStateHandler!)
    }

    func userStateChangeListener(_ auth: Auth, _ user: User?) {
        let currentUser = try? self.user.value()
        if currentUser != user {
            self.user.onNext(user)
        }
    }

    func isLogin() -> Observable<Bool> {
        return user.map { user in
            return user != nil
        }
    }

    func signIn(with credential: AuthCredential) {
        firebaseAuth.signIn(with: credential) { (_, error) in
            if error != nil {
                return
            }
        }
    }

    func signOut() {
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
