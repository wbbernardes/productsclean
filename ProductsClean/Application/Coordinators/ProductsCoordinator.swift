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
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private weak var parentCoordinator: TabBarCoordinator?

    init(navigationController: UINavigationController, parentCoordinator: TabBarCoordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    // check if deinit is being called
    deinit {
        navigationController.delegate = nil
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
        let child = ThirdCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func switchToSecondTab() {
        parentCoordinator?.tabBarController.selectedIndex = 1
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func popToSpecificVC() {
        for controller in navigationController.viewControllers {
            if let view = controller as? UIHostingController<ProductDetailView> {
                navigationController.popToViewController(view, animated: true)
            }
        }
    }
    
    func popToOnboard() {
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
            childCoordinators.removeAll()
        }
    }
}
