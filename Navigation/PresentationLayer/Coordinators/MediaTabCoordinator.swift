//
//  MediaTabCoordinator.swift
//  Navigation
//
//  Created by Maksim Kruglov on 22.11.2022.
//

import Foundation
import UIKit

class MediaTabCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    
    init (navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MediaViewController()
        
        vc.tabBarItem = UITabBarItem(title: "Media", image: UIImage(systemName: "music.note"), tag: 2)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

