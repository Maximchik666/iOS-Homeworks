//
//  AppDelegate.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appConfiguration: AppConfiguration?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let navigationController: UINavigationController = .init()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator.init(navigationController: navigationController)
        appCoordinator?.start()
        
        appConfiguration = AppConfiguration.allCases.randomElement()
        
        if let currentConfiguration = appConfiguration {
            NetworkService.request(forConfiguration: currentConfiguration)
        } else {print ("Something Went Wrong((((")}
        
        JSONReceiver.receiveJSON(forConfiguration: .fourth)
        JSONReceiver.receiveJSON(forConfiguration: .fifth)
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try Auth.auth().signOut()
        } catch {print("Some Error")}
    }
}
