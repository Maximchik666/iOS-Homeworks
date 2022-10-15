//
//  UserInfo.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.10.2022.
//

import Foundation
import UIKit

class User {
    var login: String
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

protocol UserService {
    
    func avtorization (login: String) -> User?
}

public class CurrentUserService: UserService {
    var user: User
    
    init (user: User) {
        self.user = user
    }
    
    
    func avtorization(login: String) -> User? {
        if login == user.login{
            return user
        }
        return nil
    }
}

public class TestUserService: UserService {
   var user: User
    
    init (user: User) {
        self.user = user
    }
    
    
  func avtorization(login: String) -> User? {
        if login == user.login{
            return user
        }
        return nil
    }
}



var user1 = User(login: "123", fullName: "Vasiliy Tyorkin", avatar: UIImage(named: "Ava1")!, status: "Kickin'")
var user2 = User(login: "123", fullName: "Admin Adminov", avatar: UIImage(named: "Ava2")!, status: "Strugglin'")

public var userService1 = CurrentUserService(user: user1)
public var userService_Test = TestUserService(user: user2)
