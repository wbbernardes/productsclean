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
    let fetchProductsUseCase: FetchProductsUseCaseProtocol
    let apiService: APIServiceProtocol
    let productRepository: ProductRepositoryProtocol
    
    init() {
        apiService = APIFactory.makeAPIService()
        productRepository = ProductRepositoryFactory.makeProductRepository(apiService: apiService)
        fetchProductsUseCase = FetchProductsUseCaseFactory.makeProductsUseCase(productRepository: productRepository)
    }

    func makeProductsViewModel() -> ProductsViewModel {
        return ProductsViewModel(fetchProductsUseCase: fetchProductsUseCase)
    }
}
