//
//  RealmManager.swift
//  bean
//
//  Created by dewey seo on 05/07/2021.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

class RealmManager: NSObject {
    static let shared = RealmManager()
    var realm: Realm!
    
    override init() {
        super.init()
        do {
            try self.realm = Realm()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    func observeIsLogin() -> Observable<Bool> {
        return Observable.just(false)
//        let users = realm.objects(User.self)
//        return Observable.arrayWithChangeset(from: users).map { (array, changes) -> Bool in
//            return array.count > 0
//        }
    }
    
    func saveUser(user: User) {
//        try! realm.write {
//            realm.add(user)
//        }
    }
    func deleteUser() {
//        try! realm.write{
//            realm.delete(realm.objects(User.self))
//        }
    }
}
