//
//  FileTabCoordinator.swift
//  Navigation
//
//  Created by Maksim Kruglov on 04.12.2022.
//

import Foundation
import UIKit

class FileTabCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    
    init (navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FileViewController()
        
        vc.tabBarItem = UITabBarItem(title: "Files", image: UIImage(systemName: "filemenu.and.cursorarrow"), tag: 2)
        vc.coordinator = self
        vc.fileManager = FileManagerService()
        navigationController.pushViewController(vc, animated: true)
    }
}

