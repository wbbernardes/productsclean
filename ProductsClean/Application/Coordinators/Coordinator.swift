//
//  Coordinator.swift
//  ProductsClean
//
//  Created by Wesley Brito on 31/05/23.
//

import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class WeakCoordinator {
    weak var value: Coordinator?
    
    init(_ value: Coordinator?) {
        self.value = value
    }
}

class Weak<T: AnyObject> {
    weak var value: T?
    
    init(_ value: T?) {
        self.value = value
    }
}
