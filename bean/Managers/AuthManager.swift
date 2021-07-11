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
import CryptoKit
import AuthenticationServices

enum AuthStatus {
    case Logout(_ user: FirebaseAuth.User?)
    case Login
}

class AuthManager: NSObject {
    static let shared = AuthManager()
    
    // Unhashed nonce.
    var currentNonce: String?
    
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
    }
    
    deinit {
        firebaseAuth.removeStateDidChangeListener(userStateHandler!)
    }
    
    func signOut() {
        try? firebaseAuth.signOut()
        RealmManager.shared.deleteUser()
    }
}

extension AuthManager {
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
    func finishedAppleSignIn(with credential: AuthCredential, completion: @escaping (_ user: FirebaseAuth.User?) -> Void) {
        firebaseAuth.signIn(with: credential) { [weak self] (result, error) in
            guard let firebaseUser = result?.user, error == nil else {
                console("Error in finishedAppleSignIn", error)
                self?.signOut()
                completion(nil)
                return
            }
            completion(firebaseUser)
        }
    }
}
extension AuthManager: ASAuthorizationControllerDelegate {
    @available(iOS 13, *)
    func startSignInWithAppleFlow(from: UIViewController) -> ASAuthorizationController {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        return authorizationController
        
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}
