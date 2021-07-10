//
//  AuthManager.swift
//  bean
//
//  Created by dewey seo on 16/06/2021.
//

import UIKit
import RxSwift
import FirebaseAuth
import GoogleSignIn

enum AuthStatus {
    case Logout(_ user: FirebaseAuth.User?)
    case Login
}

class AuthManager: NSObject {
    static let shared = AuthManager()
    let firebaseAuth = Auth.auth()
    var user = BehaviorSubject<FirebaseAuth.User?>(value: Auth.auth().currentUser)
    var userId: String? {
        get {
            // TODO: - fix bug. first login, can not get value
            return try? self.user.value()?.uid ?? Auth.auth().currentUser?.uid
        }
    }
    
    var userStateHandler: AuthStateDidChangeListenerHandle?
    let disposeBag = DisposeBag()
    
    override init() {
        super.init()
//        userStateHandler = firebaseAuth.addStateDidChangeListener { [weak self] auth, user in
//            self?.userStateChangeListener(auth, user)
//        }
    }
    
    deinit {
        firebaseAuth.removeStateDidChangeListener(userStateHandler!)
    }
    
//    func userStateChangeListener(_ auth: Auth, _ user: FirebaseAuth.User?) {
//        let currentUser = try? self.user.value()
//        if currentUser != user {
//            self.user.onNext(user)
//        }
//    }
    
    func finishedGoogleSignIn(with credential: AuthCredential, completion: @escaping (_ user: FirebaseAuth.User?) -> Void) {
        firebaseAuth.signIn(with: credential) { [weak self] (result, error) in
            guard let firebaseUser = result?.user, error == nil else {
                self?.signOut()
                completion(nil)
                return
            }
            completion(firebaseUser)
        }
    }
    
    func signOut() {
        try? firebaseAuth.signOut()
        RealmManager.shared.deleteUser()
    }
}


extension AuthManager {
    
}
