//
//  ProductsCoordinator.swift
//  ProductsClean
//
//  Created by Wesley Brito on 31/05/23.
//

import Foundation
import SwiftUI
import Domain

class ProductsCoordinator: NSObject, Coordinator {
    private weak var parentCoordinator: TabBarCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinator: TabBarCoordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    // check if deinit is being called
    deinit {
        print("deinit ProductsCoordinator")
    }
    
    func start() {
        navigationController.delegate = self
        let view: ProductsView = ProductsView(viewModel: ProductsFactory.makeProductsViewModel(coordinator: self))
        let hostingController: UIHostingController<ProductsView> = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func startProductDetailFlow(product: Product) {
        let view: ProductDetailView = ProductDetailView(viewModel: ProductsFactory.makeProductDetailViewModel(product: product, coordinator: self))
        let hostingController: UIHostingController<ProductDetailView> = UIHostingController(rootView: view)
        
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func startThirdFlow() {
        let thirdCoordinator = ThirdCoordinator(navigationController: navigationController)
        
        childCoordinators.append(thirdCoordinator)
        
        thirdCoordinator.parentCoordinator = self
        thirdCoordinator.start()
    }
    
    func switchToSecondTab() {
        navigationController.dismiss(animated: true)
        childCoordinators.removeAll()
        parentCoordinator?.tabBarController.selectedIndex = 1
    }
    
    func popToRoot() {
        navigationController.dismiss(animated: true)
        childCoordinators.removeAll()
        navigationController.popToRootViewController(animated: true)
    }
    
    func popToSpecificVC() {
        navigationController.dismiss(animated: true)
        childCoordinators.removeAll()
        for controller in navigationController.viewControllers {
            if let view = controller as? UIHostingController<ProductDetailView> {
                navigationController.popToViewController(view, animated: true)
            }
        }
    }
    
    func popToOnboard() {
        navigationController.dismiss(animated: true)
        parentCoordinator?.popToOnboard()
    }
}

extension ProductsCoordinator: UINavigationControllerDelegate {
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
        if fromViewController is UIHostingController<ThirdView> {
            // We're popping a thirdView; end its coordinator
            navigationController.viewControllers.removeAll(where: { $0 === fromViewController})
            childCoordinators.removeAll()
        }
    }
}
