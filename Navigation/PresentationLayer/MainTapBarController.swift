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
    let media = MediaTabCoordinator(navigationController: UINavigationController())
    let file = FileTabCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profile.start()
        feed.start()
        media.start()
        file.start()
        
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().tintColor = UIColor(named: "VKColour")
        viewControllers = [feed.navigationController, file.navigationController, media.navigationController, profile.navigationController]
    }
}
