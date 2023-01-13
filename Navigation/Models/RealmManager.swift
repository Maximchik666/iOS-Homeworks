//
//  RealmManager.swift
//  Navigation
//
//  Created by Maksim Kruglov on 11.12.2022.
//

import Foundation
import RealmSwift
import UIKit
import CoreData

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

class RealmManager {
    
    static var defaultManager = RealmManager()
    
    var realm: Realm = {
        
        CoreDataManager.defaultManager.addKey()
        
        let fetchRequest = RealmKey.fetchRequest()
        var key = try! ((CoreDataManager.defaultManager.persistentContainer.viewContext.fetch(fetchRequest)).first?.key)
        
        var result: Realm!
        if var key1 = key {
            
            print(key1.hashValue)
   
            let _ = key1.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
                SecRandomCopyBytes (kSecRandomDefault, 64, pointer.baseAddress!) }
            
            let config = Realm.Configuration(encryptionKey: key1)
            
            do {
                result = try Realm(configuration: config)
            } catch let error as NSError {
                 print (error.localizedDescription)
            }
        }
            
            return result
        }()
        
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
