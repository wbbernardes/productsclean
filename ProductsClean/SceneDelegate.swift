//
//  SceneDelegate.swift
//  ProductsClean
//
//  Created by Wesley Brito on 01/06/23.
//

import Foundation
import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        let coordinator = OnboardingCoordinator(navigationController: navigationController)
        coordinator.start()
        
//        tab flow
//        let tabBarController: UITabBarController = UITabBarController()
//        let tabBarCoordinator: TabBarCoordinator = TabBarCoordinator(tabBarController: tabBarController)
//        tabBarCoordinator.start()
//
//        window.rootViewController = tabBarController
        
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
