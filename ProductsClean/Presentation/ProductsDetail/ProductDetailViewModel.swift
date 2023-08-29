//
//  ProductDetailViewModel.swift
//  ProductsClean
//
//  Created by Wesley Brito on 09/08/23.
//

import Foundation
import Combine
import Domain

class ProductDetailViewModel: BaseViewModel {
    let product: Product
    weak var coordinator: ProductsCoordinator?
    
    init(product: Product, coordinator: ProductsCoordinator) {
        self.product = product
        self.coordinator = coordinator
    }
    
    func openThirdFlow() {
        coordinator?.startThirdFlow()
    }
}
