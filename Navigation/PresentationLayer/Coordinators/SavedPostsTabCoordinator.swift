//
//  SavedPostsCoordinator.swift
//  Navigation
//
//  Created by Maksim Kruglov on 20.12.2022.
//

import Foundation
import UIKit

class SavedPostsTabCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    
    init (navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SavedPostsController()
        
        vc.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "heart.rectangle.fill"), tag: 4)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
