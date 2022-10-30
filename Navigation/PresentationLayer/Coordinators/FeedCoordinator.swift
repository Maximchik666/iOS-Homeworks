//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Maksim Kruglov on 29.10.2022.
//

import UIKit

class FeedCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init (navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        
        let vc = FeedViewController()
        vc.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "message"), tag: 0)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openPostViewController () {
        let child = PostViewCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        print ("321")
        child.start()
    }
    
    func childDidFinish (_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    
}
