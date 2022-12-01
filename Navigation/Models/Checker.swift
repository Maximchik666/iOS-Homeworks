//
//  Checker.swift
//  Navigation
//
//  Created by Maksim Kruglov on 17.10.2022.
//

import Foundation
import FirebaseAuth
import UIKit

protocol CheckerServiceProtocol {
    
    func checkCredential(_ sender: LoginViewController, login: String, password: String)
    
    func signUp (_ sender: LoginViewController, login: String, password: String)
    
}

class CheckerService: CheckerServiceProtocol, LoginViewControllerDelegate {
    
    func checkCredential(_ sender: LoginViewController, login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) {authResult, error in
            
            guard let user = authResult?.user, error == nil else {
                let alertController = UIAlertController(title: "Sorry!", message: error!.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok! Let me Try Again", style: .default, handler: { _ in
                }))
                sender.present(alertController, animated: true, completion: nil)
                print(error!.localizedDescription)
                return
            }
            sender.coordinator?.pushToTabBarController(tapBarController: MainTabBarController())
            print("\(user.email!) Has Loged In")
        }
    }
    
    func signUp (_ sender: LoginViewController, login: String, password: String) {
        Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
            
            guard let user = authResult?.user, error == nil else {
                let alertController = UIAlertController(title: "Sorry!", message: error!.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok! Let me Try Again", style: .default, handler: { _ in
                }))
                sender.present(alertController, animated: true, completion: nil)
                print(error!.localizedDescription)
                return
            }
            sender.coordinator?.pushToTabBarController(tapBarController: MainTabBarController())
            print("\(user.email!) created")
        }
    }
}



protocol LoginViewControllerDelegate {
    
    func checkCredential(_ sender: LoginViewController, login: String, password: String)
    
    func signUp (_ sender: LoginViewController, login: String, password: String)
}

protocol LoginFactory {
    func makeLoginInspector () -> CheckerService
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> CheckerService {
        CheckerService()
    }
}
