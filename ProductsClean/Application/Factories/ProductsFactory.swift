//
//  ProductsCoordinator.swift
//  ProductsClean
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation
import Domain
import DataLayer

struct ProductsFactory {
    
    static func makeProductsViewModel(coordinator: ProductsCoordinator) -> ProductsViewModel {
        let apiService: APIServiceProtocol = APIFactory.makeAPIService()
        let productRepository: ProductRepositoryProtocol = ProductRepositoryFactory.makeProductRepository(apiService: apiService)
        let fetchProductsUseCase: FetchProductsUseCaseProtocol = FetchProductsUseCaseFactory.makeProductsUseCase(productRepository: productRepository)
        
        return ProductsViewModel(coordinator: coordinator, fetchProductsUseCase: fetchProductsUseCase)
    }
    
    static func makeProductDetailViewModel(product: Product, coordinator: ProductsCoordinator) -> ProductDetailViewModel {
        return ProductDetailViewModel(product: product, coordinator: coordinator)
    }
}
