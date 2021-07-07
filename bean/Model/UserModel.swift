//
//  UserModel.swift
//  bean
//
//  Created by dewey seo on 25/06/2021.
//

import Foundation
import FirebaseAuth
import RealmSwift


class User: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var introduce: String = ""
    @objc dynamic var profileUrl: String = ""
    
//    convenience init(user: FirebaseAuth.User) {
//        self.init()
//        id = user.uid
//        name = user.displayName ?? ""
//        email = user.email ?? ""
//        profileUrl = user.photoURL?.absoluteString ?? ""
//    }
    convenience init(_ id: String, _ name: String, _ email: String, _ introduce: String, _ profileUrl: String) {
        self.init()
        self.id = id
        self.name = name
        self.email = email
        self.profileUrl = profileUrl
    }
    
    var registUserData: [String: Any]? {
        get {
            return [
                "id": id,
                "name": name,
                "email": email,
                "introduce": introduce,
                "profileUrl": profileUrl
            ]
        }
    }
}
