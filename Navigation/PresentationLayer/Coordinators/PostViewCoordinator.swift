//
//  PostViewCoordinator.swift
//  Navigation
//
//  Created by Maksim Kruglov on 30.10.2022.
//

import Foundation
import UIKit

class PostViewCoordinator: Coordinator {
    
    weak var parentCoordinator: FeedCoordinator?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
        print("Nav is Set")
    }
    
    func start() {
        let vc = PostViewController()
        vc.coordinator = self
        print("000")
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func openInfoViewController () {
        let vc = InfoViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func destroyMe() {
        parentCoordinator?.childDidFinish(self)
    }
}
