//
//  TabBarCoordinator.swift
//  ProductsClean
//
//  Created by Wesley Brito on 01/06/23.
//

import Foundation
import SwiftUI

class TabBarCoordinator: NSObject, Coordinator {
    private weak var parentCoordinator: OnboardingCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController = UITabBarController()

    init(
//        tabBarController: UITabBarController,
        navigationController: UINavigationController,
        parentCoordinator: OnboardingCoordinator
    ) {
//        self.tabBarController = tabBarController
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }

    // check if deinit is being called
    deinit {
        print("deinit TabBarCoordinator")
    }
    
    func start() {
        navigationController.setNavigationBarHidden(true, animated: false)
        let productsCoordinator = ProductsCoordinator(navigationController: UINavigationController(), parentCoordinator: self)
        let favoriteCoordinator = FavoriteCoordinator(navigationController: UINavigationController(), parentCoordinator: self)

        // Add each coordinator to the childCoordinators array
        childCoordinators.append(productsCoordinator)
        childCoordinators.append(favoriteCoordinator)
        
        // Create the tab bar items
        productsCoordinator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        favoriteCoordinator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        // Add the navigation controllers to the tab bar controller
        tabBarController.viewControllers = [productsCoordinator.navigationController, favoriteCoordinator.navigationController]
        
        // Start each coordinator
        productsCoordinator.start()
        favoriteCoordinator.start()
        
        // Push the tab bar controller into the navigation stack
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    func popToOnboard() {
        parentCoordinator?.popToOnboard()
    }
}
