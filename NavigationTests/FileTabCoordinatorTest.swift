//
//  FileTabCoordinatorTest.swift
//  NavigationTests
//
//  Created by Maksim Kruglov on 15.02.2023.
//

import XCTest
@testable import Navigation

final class FileTabCoordinatorTest: XCTestCase {
    
    var coordinator: FeedCoordinator!
    var childCoordinator: Coordinator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        coordinator = FeedCoordinator(navigationController: UINavigationController())
    }
    
    override func tearDownWithError() throws {
        coordinator = nil
        try super.tearDownWithError()
    }
    
    
    func testCoordinatorCorrectlyOpensAndClose() throws {
        
        coordinator.openPostViewController()
        XCTAssertEqual(coordinator.childCoordinators.count, 1)
       
        childCoordinator = coordinator.childCoordinators[0]
        coordinator.childDidFinish(childCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count, 0)
    }
    
}
