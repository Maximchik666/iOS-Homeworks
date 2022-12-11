//
//  RealmManager.swift
//  Navigation
//
//  Created by Maksim Kruglov on 11.12.2022.
//

import Foundation
import RealmSwift
import UIKit

class Credentials: Object {
    
    @Persisted (primaryKey: true) var primaryKey: ObjectId
    
    @Persisted var login: String
    @Persisted var password: String
    
    
    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
}

class RealmManager{
    
    var realm = try! Realm()
    var credentials: [Credentials] = []
    
    func reloadData() {
        credentials = Array(realm.objects(Credentials.self))
    }
    
    func saveCredentials (login: String, password: String) {
        try! realm.write {
            let credentials = Credentials(login: login, password: password)
            realm.add(credentials)
        }
    }
    
    func checkCredentials (viewController: LoginViewController) {
        reloadData()
        
        if !credentials.isEmpty {
            viewController.coordinator?.pushToTabBarController(tapBarController: MainTabBarController())
        }
        
    }
    
    
}
