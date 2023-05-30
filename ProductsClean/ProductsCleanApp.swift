//
//  ProductsCleanApp.swift
//  ProductsClean
//
//  Created by Wesley Brito on 20/05/23.
//

import SwiftUI
import UIKit
import Domain

@main
struct ProductsCleanApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    init() {
        print("passei no cleanApp")
    }
    
    var body: some Scene {
        WindowGroup {
//            ProductsView(viewModel: ProductsFactory.makeProductsViewModel())
//                .environmentObject(envApp)
//                .environmentObject(envDetail)

//            ContentView()
//                .environmentObject(envApp)
        }
    }
}

//@main
final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        return true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sessionRole = connectingSceneSession.role
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: sessionRole)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
        
    private let coordinator: Coordinator<MapRouter> = .init(startingRoute: .product)
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}

open class Coordinator<Router: NavigationRouter>: ObservableObject {
    
    public let navigationController: UINavigationController
    public let startingRoute: Router?
    
    public init(navigationController: UINavigationController = .init(), startingRoute: Router? = nil) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
    }
    
    public func start() {
        guard let route = startingRoute else { return }
        show(route)
    }
    
    public func show(_ route: Router, animated: Bool = true) {
        let view = route.view()
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        switch route.transition {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .presentModally:
            viewController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated)
        case .presentFullscreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
        }
    }
    
    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    open func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: true)
//        { [weak self] in
//            /// because there is a leak in UIHostingControllers that prevents from deallocation
//            self?.navigationController.viewControllers
//        }
    }
}

public protocol NavigationRouter {
    
    associatedtype V: View

    var transition: NavigationTranisitionStyle { get }
    
    /// Creates and returns a view of assosiated type
    ///
    @ViewBuilder
    func view() -> V
}

public enum NavigationTranisitionStyle {
    case push
    case presentModally
    case presentFullscreen
}

public enum MapRouter: NavigationRouter {
    
    case product
    case productDetail(product: Product)
    case another(product: Product)
    
    public var transition: NavigationTranisitionStyle {
        switch self {
        case .product:
            return .push
        case .productDetail:
            return .push
        case .another:
            return .presentFullscreen
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .product:
            ProductsView(viewModel: ProductsFactory.makeProductsViewModel())
        case .productDetail(product: let product):
            ProductDetailView(product: product)
        case .another(product: let product):
            AnotherView(product: product)
        }
    }
}
