//
//  AuthManager.swift
//  bean
//
//  Created by dewey seo on 16/06/2021.
//

import UIKit
import RxSwift
import FirebaseAuth

class AuthManager: NSObject{
    static let shared = AuthManager()
    let firebaseAuth = Auth.auth()
    var user: User?
    
    func isLogin() -> Observable<Bool> {
        return Observable.create({ [weak self] seal in
            self?.user = self?.firebaseAuth.currentUser
            seal.onNext(self?.user != nil)
            self?.firebaseAuth.addStateDidChangeListener { (auth, user) in
                if(self?.user != user) {
                    self?.user = user
                    seal.onNext(user != nil)
                }
            }
            return Disposables.create()
        })
    }
    
    func signIn(with credential: AuthCredential) {
        firebaseAuth.signIn(with: credential) { (authResult, error) in
            if (error != nil) {
                return
            }
        }
    }
    
    func signOut() {
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
