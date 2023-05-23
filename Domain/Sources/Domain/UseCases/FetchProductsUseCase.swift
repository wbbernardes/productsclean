//
//  FetchProductsUseCase.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation
import Combine

public protocol ProductRepositoryProtocol {
    func fetchProducts() async throws -> [Product]
}

public protocol FetchProductsUseCaseProtocol {
    func execute() async throws -> [Product]
}

class FetchProductsUseCase: FetchProductsUseCaseProtocol {
    private let productRepository: ProductRepositoryProtocol
    

    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
    }

    func execute() async throws -> [Product] {
        return try await productRepository.fetchProducts()
    }
}

public struct FetchProductsUseCaseFactory {
    public static func makeProductsUseCase(productRepository: ProductRepositoryProtocol) -> FetchProductsUseCaseProtocol {
        return FetchProductsUseCase(productRepository: productRepository)
    }
}
