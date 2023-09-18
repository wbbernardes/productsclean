//
//  ThirdCoordinatorTests.swift
//  ProductsCleanTests
//
//  Created by Wesley Brito on 04/09/23.
//

@testable import ProductsClean
import XCTest
import SwiftUI
import Domain

class ThirdCoordinatorTests: XCTestCase {
    
    var sut: ThirdCoordinator!
    var mockNavigationController: UINavigationController!
    var mockParentCoordinator: MockProductsCoordinator!
    
    override func setUp() {
        super.setUp()
        
        mockNavigationController = UINavigationController()
        mockParentCoordinator = MockProductsCoordinator()
        sut = ThirdCoordinator(navigationController: mockNavigationController)
        sut.parentCoordinator = mockParentCoordinator
    }
    
    override func tearDown() {
        sut = nil
        mockNavigationController = nil
        mockParentCoordinator = nil
        
        super.tearDown()
    }
    
    func test_start_presentsThirdView() {
        sut.start()
        
        let presentedVC = mockNavigationController.presentedViewController as? UINavigationController
        let rootVC = presentedVC?.viewControllers.first as? UIHostingController<ThirdView>
        
        XCTAssertNotNil(rootVC)
    }
    
    func test_presentFourthView_presentsFourthView() {
        sut.start()
        sut.presentFourthView()
        
        let presentedVC = sut.thirdNavigationController?.presentedViewController as? UIHostingController<FourthView>
        
        XCTAssertNotNil(presentedVC)
    }
    
    func test_sheetFifthView_presentsFifthView() {
        sut.start()
        sut.sheetFifthView()
        
        let presentedVC = sut.thirdNavigationController?.presentedViewController as? UIHostingController<FifthView>
        
        XCTAssertNotNil(presentedVC)
    }
    
    func test_switchTab_callsParentSwitchToSecondTab() {
        sut.switchTab()
        
        XCTAssertTrue(mockParentCoordinator.isSwitchToSecondTabCalled)
    }
    
    // ... Continue with other test methods ...
}

class MockProductsCoordinator: ProductsCoordinator {
    
    var isStartCalled = false
    var isStartProductDetailFlowCalled = false
    var isStartThirdFlowCalled = false
    var isSwitchToSecondTabCalled = false
    var isPopToRootCalled = false
    var isPopToSpecificVCCalled = false
    var isPopToOnboardCalled = false
    
    // This init method is required since your ProductsCoordinator init method has parameters.
    init() {
        let navigationController = UINavigationController()
        let mockTabBarCoordinator = MockTabBarCoordinator(navigationController: <#UINavigationController#>, parentCoordinator: <#OnboardingCoordinator#>)
        super.init(navigationController: navigationController, parentCoordinator: mockTabBarCoordinator)
    }

    override func start() {
        isStartCalled = true
    }
    
    override func startProductDetailFlow(product: Product) {
        isStartProductDetailFlowCalled = true
    }
    
    override func startThirdFlow() {
        isStartThirdFlowCalled = true
    }
    
    override func switchToSecondTab() {
        isSwitchToSecondTabCalled = true
    }
    
    override func popToRoot() {
        isPopToRootCalled = true
    }
    
    override func popToSpecificVC() {
        isPopToSpecificVCCalled = true
    }
    
    override func popToOnboard() {
        isPopToOnboardCalled = true
    }
    
}

class MockTabBarCoordinator: TabBarCoordinator {
    var didCallStart = false
    var didPopToOnboard = false
    
    override func start() {
        didCallStart = true
    }

    override func popToOnboard() {
        didPopToOnboard = true
    }
}
