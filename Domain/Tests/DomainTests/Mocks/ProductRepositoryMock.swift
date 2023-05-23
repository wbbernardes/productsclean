//
//  ProductRepositoryMock.swift
//
//
//  Created by Wesley Brito on 21/05/23.
//

import Combine
import Domain

public class ProductRepositoryMock: ProductRepositoryProtocol {
    
    public enum APIError: Error {
        case badRequest // 400
        case unauthorized // 401
        case forbidden // 403
        case notFound // 404
        case serverError // 500
        case unknown
    }
    
    public var nextResult: Result<[Product], Error>?
    
    public func fetchProducts() async throws -> [Product] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // sleep for 1 second
        
        guard let nextResult = nextResult else {
            throw APIError.serverError // replace with an appropriate error
        }
        
        switch nextResult {
        case .success(let mockProducts):
            return mockProducts
        case .failure(let error):
            throw error
        }
    }
}
