//
//  SelectedUserSingletone.swift
//  Navigation
//
//  Created by Maksim Kruglov on 29.10.2022.
//

import Foundation

final class SelectedUser {
    
    static let shared = SelectedUser()
    
    var user: User? = nil
    
    private init(user: User? = nil) {
        self.user = user
    }
}
