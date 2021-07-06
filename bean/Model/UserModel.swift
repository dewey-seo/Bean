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
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var email: String?
    @objc dynamic var introduce: String?
    @objc dynamic var profileUrl: String?
    @objc dynamic var thumbnailUrl: String?
    
    convenience init(user: FirebaseAuth.User) {
        self.init()
        id = user.uid
        name = user.displayName
        email = user.email
        profileUrl = user.photoURL?.absoluteString
    }
    
    var registUserData: [String: Any]? {
        get {
            if let id = id, let name = name, let email = email {
                return [
                    "id": id,
                    "name": name,
                    "email": email,
                    "introduce": introduce ?? "",
                    "profileUrl": profileUrl ?? "",
                    "thumbnailUrl": thumbnailUrl ?? "",
                ]
            }
            return nil
        }
    }
}
