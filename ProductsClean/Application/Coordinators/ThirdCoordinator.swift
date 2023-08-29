//
//  ThirdCoordinator.swift
//  ProductsClean
//
//  Created by Wesley Brito on 01/06/23.
//

import Foundation
import SwiftUI

class ThirdCoordinator: Coordinator {
    weak var parentCoordinator: ProductsCoordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // check if deinit is being called
    deinit {
        print("deinit ThirdCoordinator")
    }
    
    func start() {
        let view: ThirdView = ThirdView(coordinator: self)
        let hostingController: UIHostingController<ThirdView> = UIHostingController(rootView: view)
        
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func presentFourthView() {
        let view: FourthView = FourthView(coordinator: self)
        let hostingController: UIHostingController<FourthView> = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .fullScreen
        navigationController.topViewController?.present(hostingController, animated: true)
    }
    
    func dismissFourthView() {
        navigationController.topViewController?.dismiss(animated: true)
    }
    
    func sheetFifthView() {
        let view: FifthView = FifthView(coordinator: self)
        let hostingController: UIHostingController<FifthView> = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .pageSheet
        
        navigationController.topViewController?.present(hostingController, animated: true, completion: {
            if let sheet = hostingController.sheetPresentationController {
                sheet.detents = [.medium()]
            }
        })
    }
    
    func sheetDismiss() {
        navigationController.topViewController?.dismiss(animated: true)
    }
    
    func switchTab() {
        parentCoordinator?.switchToSecondTab()
    }
    
    func popToSpecificVC() {
        parentCoordinator?.popToSpecificVC()
    }
    
    func popToOnboarding() {
        parentCoordinator?.popToOnboard()
    }
    
    func popToRoot() {
        parentCoordinator?.popToRoot()
    }
}
