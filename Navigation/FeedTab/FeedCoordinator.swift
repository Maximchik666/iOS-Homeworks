//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Maksim Kruglov on 29.10.2022.
//

import UIKit

class FeedCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    
    var navigationController: UINavigationController
    var childrenCoordinators: [Coordinator] = []
    
    init (navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FeedViewController()
        vc.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "message"), tag: 0)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
