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
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let view: ThirdView = ThirdView(coordinator: self)
        let hostingController: UIHostingController<ThirdView> = UIHostingController(rootView: view)
        
        navigationController.pushViewController(hostingController, animated: true)
    }
}
