//
//  Checker.swift
//  Navigation
//
//  Created by Maksim Kruglov on 17.10.2022.
//

import Foundation

class Checker {
    
    static let shared = Checker()
    
    private let login = "admin"
    private let password = "123"
    
    func check (login: String, password: String) -> Bool {
        
        login == self.login && password == self.password ? true : false
        
    }
}

protocol LoginViewControllerDelegate {
    
    func check (_ sender: LoginViewController,
                login: String,
                password: String) -> Bool
}

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(_ sender: LoginViewController, login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}
