//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Maksim Kruglov on 29.10.2022.
//

import UIKit

class ProfileTabCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childrenCoordinators: [Coordinator] = []

    
    init (navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProfileViewController()
        
        vc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        vc.coordinator = self
        vc.user = SelectedUser.shared.user
        navigationController.pushViewController(vc, animated: true)
    }
}

