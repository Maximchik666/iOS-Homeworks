//
//  LoginDelegateDummy.swift
//  NavigationTests
//
//  Created by Maksim Kruglov on 15.02.2023.
//

import Foundation
@testable import Navigation

class LoginDelegateDummy: LoginViewControllerDelegate {
   
    func checkCredential(_ sender: Navigation.LoginViewController, login: String, password: String) {
        sender.coordinator?.pushToTabBarController(tapBarController: MainTabBarController())
    }
    
    func signUp(_ sender: Navigation.LoginViewController, login: String, password: String) {
        sender.coordinator?.pushToTabBarController(tapBarController: MainTabBarController())
    }
}
