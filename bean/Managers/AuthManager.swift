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
    case Logout
    case Login
    case Register(user: FirebaseAuth.User)
}

class AuthManager: NSObject {
    static let shared = AuthManager()
    let firebaseAuth = Auth.auth()
    var user = BehaviorSubject<FirebaseAuth.User?>(value: Auth.auth().currentUser)
    
    var userStateHandler: AuthStateDidChangeListenerHandle?
    let disposBag = DisposeBag()
    
    override init() {
        super.init()
        userStateHandler = firebaseAuth.addStateDidChangeListener { [weak self] auth, user in
            self?.userStateChangeListener(auth, user)
        }
    }
    
    deinit {
        firebaseAuth.removeStateDidChangeListener(userStateHandler!)
    }
    
    func userStateChangeListener(_ auth: Auth, _ user: FirebaseAuth.User?) {
        let currentUser = try? self.user.value()
        if currentUser != user {
            self.user.onNext(user)
        }
    }
    
//    func isLogin() -> Observable<AuthStatus> {
//        return user.flatMapLatest { firebaseUser in
//            return Observable.create { observer in
//
//                return Disposables.create()
//            }
//        }
//        return Observable<AuthStatus>.combineLatest(user).flatMap { firebaseUser in
//
//        }
//        return user.flatMapLatest { (firebaseUser: FirebaseAuth.User?) -> Observable<AuthStatus> in
//            return Observable.create { observer in
//                if let firebaseUser = firebaseUser {
//                    UserService.shared.getUser(firebaseUser) { user in
//                        observer.onNext(.Login(isRegsterd: user != nil))
//                    }
//                } else {
//                    observer.onNext(.Logout)
//                }
//                return Disposables.create()
//            }
//        }
//    }
    
    func finishedGoogleSignIn(with credential: AuthCredential) {
        firebaseAuth.signIn(with: credential) { [weak self] (result, error) in
            guard let firebaseUser = result?.user, error == nil else {
                self?.signOut()
                return
            }
            let user = User(user: firebaseUser)
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


extension AuthManager {
    
}
