//
//  ProdFactory.swift
//  ProductsClean
//
//  Created by Wesley Brito on 22/05/23.
//

import Foundation
import Factory
import Domain
import DataLayer

extension Container {
    var apiSerice: Factory<APIServiceProtocol> {
        self { APIFactory.makeAPIService() }
    }
    
    var productRepository: Factory<ProductRepositoryProtocol> {
        self { ProductRepositoryFactory.makeProductRepository(apiService: self.apiSerice.resolve()) }
    }
    
    var fetchProductsUseCase: Factory<FetchProductsUseCaseProtocol> {
        self { FetchProductsUseCaseFactory.makeProductsUseCase(productRepository: self.productRepository.resolve()) }
    }
    
    var productsViewModel: Factory<ProductsViewModel> {
        self {
            ProductsViewModel(fetchProductsUseCase: self.fetchProductsUseCase.resolve())
        }
    }
}
