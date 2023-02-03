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
        let vc = FileLoginViewController()
        vc.tabBarItem = UITabBarItem(title: String(localized: "TabBarFiles"), image: UIImage(systemName: "filemenu.and.cursorarrow"), tag: 3)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToFilesTab (filesViewController: FileViewController) {
        
        let vc = filesViewController
        vc.coordinator = self
        vc.fileManager = FileManagerService()
        navigationController.pushViewController(vc, animated: true)
        
    }
}

