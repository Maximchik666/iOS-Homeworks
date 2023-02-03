//
//  MapCoordinator.swift
//  Navigation
//
//  Created by Maksim Kruglov on 21.01.2023.
//

import Foundation
import UIKit

class MapTabCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    
    init (navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MapViewController()
        vc.tabBarItem = UITabBarItem(title: String(localized: "TabBarMap"), image: UIImage(systemName: "map"), tag: 5)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
