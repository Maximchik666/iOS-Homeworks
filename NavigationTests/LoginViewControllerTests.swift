//
//  LoginViewControllerTests.swift
//  NavigationTests
//
//  Created by Maksim Kruglov on 15.02.2023.
//

import XCTest
@testable import Navigation

final class LoginViewControllerTests: XCTestCase {
    
    var controller: LoginViewController!
    var coordinator = AppCoordinator(navigationController: UINavigationController())
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        controller = LoginViewController()
    }
    
    override func tearDownWithError() throws {
        controller = nil
        try super.tearDownWithError()
    }
    
    func testLoginWithExistingCredentials () throws {
       
        controller.loginDelegate = LoginDelegateDummy()
        controller.coordinator = coordinator
        
        controller.loginDelegate?.checkCredential(controller, login: "123", password: "123")
        
        XCTAssertEqual(controller.coordinator!.isBeingPushedToNextScreen, true)
    }
    
    
    func testLoginWithNewCredentials () throws {
       
        controller.loginDelegate = LoginDelegateDummy()
        controller.coordinator = coordinator
        
        controller.loginDelegate?.signUp(controller, login: "123", password: "123")
        
        XCTAssertEqual(controller.coordinator!.isBeingPushedToNextScreen, true)
    }
    
    
}
