//
//  MainTapBarController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 29.10.2022.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    let profile = ProfileTabCoordinator(navigationController: UINavigationController())
    let feed = FeedCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profile.start()
        feed.start()
        
        viewControllers = [feed.navigationController, profile.navigationController]
    }
}
