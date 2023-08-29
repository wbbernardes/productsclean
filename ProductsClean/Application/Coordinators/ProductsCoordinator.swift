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
        thirdCoordinator.parentCoordinator = self
        thirdCoordinator.start()
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
