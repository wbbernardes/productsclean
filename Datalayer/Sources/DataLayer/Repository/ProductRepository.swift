//
//  ProductRepository.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation
import Combine
import Domain

struct ProductRepository: ProductRepositoryProtocol {
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchProducts() async throws -> [Product] {
        let object: [ProductDTO] = try await apiService.request(.getProducts)
        return object.map { $0.toDomain() }
    }
}

public struct ProductRepositoryFactory {
    public static func makeProductRepository(apiService: APIServiceProtocol) -> ProductRepositoryProtocol {
        return ProductRepository(apiService: apiService)
    }
}
