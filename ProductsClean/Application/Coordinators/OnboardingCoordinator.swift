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
    var navigationController: UINavigationController = UINavigationController()
    var tabBarController: UITabBarController = UITabBarController()
    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }

    func start() {
//        navigationController.delegate = self
        navigationController.setNavigationBarHidden(true, animated: false)
        let view: OnboardingView = OnboardingView(coordinator: self)
        let hostingController: UIHostingController<OnboardingView> = UIHostingController(rootView: view)
        
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func startTabFlow() {
        let tabBarCoordinator: TabBarCoordinator = TabBarCoordinator(tabBarController: tabBarController, navigationController: navigationController, self)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
    func popToOnboard() {
        childCoordinators.removeAll()
        navigationController.popToRootViewController(animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

//extension OnboardingCoordinator: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        // Read the view controller we’re moving from.
//        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
//            return
//        }
//
//        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
//        if navigationController.viewControllers.contains(fromViewController) {
//            return
//        }
//
//        if let tabBarController = fromViewController as? UITabBarController,
//            var viewControllers = tabBarController.viewControllers {
//            viewControllers.removeAll()
//            childCoordinators.removeAll()
//        }
//    }
//}
