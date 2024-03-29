//
//  OnboardingCoordinator.swift
//  ProductsClean
//
//  Created by Wesley Brito on 31/05/23.
//

import UIKit
import SwiftUI

class OnboardingCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.setNavigationBarHidden(true, animated: false)
        let view: OnboardingView = OnboardingView(coordinator: self)
        let hostingController: UIHostingController<OnboardingView> = UIHostingController(rootView: view)
        
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func startTabFlow() {
        let tabBarCoordinator = TabBarCoordinator(
//            tabBarController: tabBarController,
            navigationController: navigationController,
            parentCoordinator: self
        )
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
    func popToOnboard() {
        childCoordinators.removeAll()
        navigationController.popToRootViewController(animated: true)
    }
}
