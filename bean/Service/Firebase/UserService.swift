//
//  UserService.swift
//  bean
//
//  Created by dewey seo on 25/06/2021.
//

import FirebaseAuth
import FirebaseFirestore

class UserService: FirebaseService {
    static let shared = UserService()
    
    let COLLECTION_PATH = "Users"
    
    func getUser(_ firebaseUser: FirebaseAuth.User, _ completion: @escaping (_ user: User?) -> Void) {
        let firebaseUid = firebaseUser.uid
        
        self.store.collection(COLLECTION_PATH).document(firebaseUid).getDocument { (document, error) in
            guard let document = document, document.exists else { return completion(nil) }
            completion(User(user: firebaseUser))
        }
    }
    
    func registerUser(user: User, _ completion: @escaping (_ result: Bool) -> Void) {
        guard let id = user.id, let userData = user.registUserData else {
            return completion(false)
        }
        
        self.store.collection(COLLECTION_PATH).document(id).setData(userData) { error in
            completion(error == nil)
        }
    }
}
