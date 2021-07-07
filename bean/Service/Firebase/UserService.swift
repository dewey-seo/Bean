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
            guard let data = document.data(),
                  let id = data["id"] as? String,
                  let name = data["name"] as? String,
                  let profileUrl = data["profileUrl"] as? String,
                  let introduce = data["introduce"] as? String,
                  let email = data["email"] as? String else {
                    completion(nil)
                    return
                  }
            let user = User(id, name, email, introduce, profileUrl)
            RealmManager.shared.saveUser(user: user)
        }
    }
    
    func registerUser(user: User, _ completion: @escaping (_ result: Bool) -> Void) {
        guard let userData = user.registUserData else {
            return completion(false)
        }
        
        self.store.collection(COLLECTION_PATH).document(user.id).setData(userData) { error in
            completion(error == nil)
        }
    }
}
