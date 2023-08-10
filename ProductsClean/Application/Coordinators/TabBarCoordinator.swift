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
    var tabBarController: UITabBarController

    init(tabBarController: UITabBarController, navigationController: UINavigationController, _ parentCoordinator: OnboardingCoordinator) {
        self.tabBarController = tabBarController
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }

    // check if deinit is being called
    deinit {
//        navigationController.delegate = nil
        print("deinit TabBarCoordinator")
    }
    
    func start() {
        navigationController.delegate = self
        navigationController.setNavigationBarHidden(true, animated: false)
        let productsCoordinator = ProductsCoordinator(navigationController: UINavigationController(), parentCoordinator: self)
        let favoriteCoordinator = FavoriteCoordinator(navigationController: UINavigationController(), parentCoordinator: self)
        
        // Add each coordinator to the childCoordinators array
        childCoordinators.append(productsCoordinator)
        childCoordinators.append(favoriteCoordinator)

        // Start each coordinator
        productsCoordinator.start()
        favoriteCoordinator.start()

        // Create the tab bar items
        productsCoordinator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        favoriteCoordinator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        // Add the navigation controllers to the tab bar controller
        tabBarController.viewControllers = [productsCoordinator.navigationController, favoriteCoordinator.navigationController]
        
        // Push the tab bar controller into the navigation stack
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    func popToOnboard() {
        parentCoordinator?.popToOnboard()
    }
}

extension TabBarCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if fromViewController is UIHostingController<ProductsView> || fromViewController is UIHostingController<ProductDetailView> {
            // We're popping a thirdView; end its coordinator
            childCoordinators.removeAll()
        }
        
        if let tabBarController = fromViewController as? UITabBarController,
            var viewControllers = tabBarController.viewControllers {
            viewControllers.removeAll()
            childCoordinators.removeAll()
        }
    }
}
