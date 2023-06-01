//
//  TabBarCoordinator.swift
//  ProductsClean
//
//  Created by Wesley Brito on 01/06/23.
//

import Foundation
import SwiftUI

class TabBarCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var tabBarController: UITabBarController

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        navigationController.delegate = self
        let productsCoordinator = ProductsCoordinator(navigationController: UINavigationController())
        let favoriteCoordinator = FavoriteCoordinator(navigationController: UINavigationController())

        // Add parent reference
        productsCoordinator.parentCoordinator = self
        favoriteCoordinator.parentCoordinator = self
        
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
    
    /// This is for cases you need to leave the tab, it will garantee you clean you child from memory.
    /// - Parameter child: coordinator
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
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
        
        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a productsView
        if let productsView = fromViewController as? UIHostingController<ProductsView> {
            // We're popping a productsView; end its coordinator
            childDidFinish(productsView.rootView.viewModel.coordinator)
        }
        
        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a FavoriteView
        if let favoriteView = fromViewController as? UIHostingController<FavoriteView> {
            // We're popping a FavoriteView; end its coordinator
            childDidFinish(favoriteView.rootView.coordinator)
        }
    }
}
