//
//  OnboardingCoordinator.swift
//  ProductsClean
//
//  Created by Wesley Brito on 31/05/23.
//

import UIKit
import SwiftUI

class OnboardingCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController = UITabBarController()
    var tabBarCoordinator: TabBarCoordinator?
    
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
        tabBarCoordinator = TabBarCoordinator(tabBarController: tabBarController, navigationController: navigationController, self)
        tabBarCoordinator?.start()
    }
    
    func popToOnboard() {
        tabBarCoordinator = nil
        navigationController.popToRootViewController(animated: true)
    }
}
