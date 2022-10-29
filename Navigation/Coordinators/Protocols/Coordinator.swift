//
//  Coordinator.swift
//  Navigation
//
//  Created by Maksim Kruglov on 29.10.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController {get set}
    var childrenCoordinators: [Coordinator] {get set}
    
    func start()
}
