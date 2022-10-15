//
//  UserInfo.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.10.2022.
//

import Foundation
import UIKit

public class User {
    public var login: String
    public var fullName: String
    public var avatar: UIImage
    public var status: String
    
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
   public var user: User
    
    init (user: User) {
        self.user = user
    }
    
    
  public  func avtorization(login: String) -> User? {
        if login == user.login{
            return user
        }
        return nil
    }
}


public var user1 = User(login: "123", fullName: "Vasiliy Tyorkin", avatar: UIImage(named: "Ava1")!, status: "Kickin...")

public var userService1 = CurrentUserService(user: user1)
