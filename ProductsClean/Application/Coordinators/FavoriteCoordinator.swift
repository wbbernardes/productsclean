//
//  FavoriteCoordinator.swift
//  ProductsClean
//
//  Created by Wesley Brito on 01/06/23.
//

import Foundation
import SwiftUI

class FavoriteCoordinator: Coordinator {
    private weak var parentCoordinator: TabBarCoordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, parentCoordinator: TabBarCoordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    deinit {
        print("deinit FavoriteCoordinator")
    }
    
    func start() {
        let view: FavoriteView = FavoriteView(coordinator: self)
        let hostingController: UIHostingController<FavoriteView> = UIHostingController(rootView: view)
        
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func popToOnboard() {
        parentCoordinator?.popToOnboard()
    }
}
