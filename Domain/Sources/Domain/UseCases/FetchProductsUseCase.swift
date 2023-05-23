//
//  FetchProductsUseCase.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation
import Combine

public protocol ProductRepositoryProtocol {
    @available(iOS 15.0, *)
    @available(macOS 10.15, *)
    func fetchProducts() async throws -> [Product]
}

@available(iOS 15.0, *)
@available(macOS 10.15, *)
public protocol FetchProductsUseCaseProtocol {
    func execute() async throws -> [Product]
}

class FetchProductsUseCase: FetchProductsUseCaseProtocol {
    private let productRepository: ProductRepositoryProtocol
    

    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
    }

    @available(iOS 15.0, *)
    @available(macOS 10.15, *)
    func execute() async throws -> [Product] {
        return try await productRepository.fetchProducts()
    }
}

@available(iOS 15.0, *)
@available(macOS 10.15, *)
public struct FetchProductsUseCaseFactory {
    public static func makeProductsUseCase(productRepository: ProductRepositoryProtocol) -> FetchProductsUseCaseProtocol {
        return FetchProductsUseCase(productRepository: productRepository)
    }
}
