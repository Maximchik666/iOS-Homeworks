//
//  Checker.swift
//  Navigation
//
//  Created by Maksim Kruglov on 17.10.2022.
//

import Foundation

class Checker {
    
    static let shared = Checker()
    
    private let login = ""
    var password: String = {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<3).map{ _ in letters.randomElement()! })
    }()
    
    private init () {}
    
    
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


protocol LoginFactory {
    func makeLoginInspector () -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
