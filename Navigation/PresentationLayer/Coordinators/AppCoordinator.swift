//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Maksim Kruglov on 29.10.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
#if DEBUG
        let userInfo = TestUserService(user: User(login: "", fullName: String(localized: "ProfileNameDebug"), avatar: UIImage(named: "Ava1")!, status: String(localized: "StatusDebug")))
        SelectedUser.shared.user = userInfo.user
#else
        let userInfo = CurrentUserService(user:User(login: "", fullName: String(localized: "ProfileNameRelease"), avatar: UIImage(named: "Ava2")!, status: String(localized: "StatusRelease")) )
        SelectedUser.shared.user = userInfo.user
#endif
        
        let vc = LoginViewController()
        
        vc.setUserInfo(userInfo: userInfo)
        vc.loginDelegate = MyLoginFactory().makeLoginInspector()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
 
    func pushToTabBarController (tapBarController : MainTabBarController ){
        navigationController.pushViewController(tapBarController, animated: true)
    }
    
}

