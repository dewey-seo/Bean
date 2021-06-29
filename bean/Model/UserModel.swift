//
//  UserModel.swift
//  bean
//
//  Created by dewey seo on 25/06/2021.
//

import Foundation
import FirebaseAuth

enum UserSNSType: String, Codable {
    case unknown = ""
    case google = "google.com"
}

struct User: Codable {
    var id: String?
    var sns: UserSNSType?
    var name: String?
    var email: String?
    var description: String?
    var profileUrl: URL?
    var thumbnailUrl: String?
    var phone: String?
    
    init(user: FirebaseAuth.User) {
        id = user.uid
        name = user.displayName
        email = user.email
        profileUrl = user.photoURL
        phone = user.phoneNumber
        sns = UserSNSType(rawValue: user.providerID) ?? UserSNSType.unknown
    }
    
    var registUserData: [String: Any]? {
        get {
            if let id = id, let name = name, let email = email {
                return [
                    "id": id,
                    "name": name,
                    "email": email,
                    "description": description ?? "",
                    "profileUrl": profileUrl?.absoluteString ?? "",
                    "thumbnailUrl": thumbnailUrl ?? "",
                    "phone": phone ?? ""
                ]
            }
            return nil
        }
    }
}
