//
//  ProductRepositoryTests.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import XCTest
import Combine
import Domain
@testable import DataLayer

class ProductRepositoryTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    var apiServiceMock: APIServiceMock!
    var productRepository: ProductRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        
        apiServiceMock = APIServiceMock()
        productRepository = ProductRepository(apiService: apiServiceMock)
    }
    
    override func tearDown() {
        apiServiceMock = nil
        productRepository = nil
        
        super.tearDown()
    }
    
    func testFetchProductsReturnsProducts() async {
        // Given
        let expectedProducts = [ProductDTO(id: 1, title: "Test Product", price: 10.0, description: "This is a test product", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", category: "test")]
        
        apiServiceMock.nextResult = .success(expectedProducts)
        
        // When
        do {
            let products = try await productRepository.fetchProducts()
            // Then
            XCTAssertEqual(products.count, expectedProducts.count)
        } catch {
            XCTFail("Expected success, but got \(error) instead")
        }
    }
    
    func testFetchProductsReturnsError() async {
        // Given
        let expectedError = APIError.serverError
        apiServiceMock.nextResult = .failure(expectedError)
        
        // When
        do {
            let _ = try await productRepository.fetchProducts()
            XCTFail("Expected failure, but got success instead")
        } catch {
            // Then
            XCTAssertEqual(error as? APIError, expectedError)
        }
    }
}






