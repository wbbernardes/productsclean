//
//  Coordinator.swift
//  ProductsClean
//
//  Created by Wesley Brito on 31/05/23.
//

import UIKit

public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}
