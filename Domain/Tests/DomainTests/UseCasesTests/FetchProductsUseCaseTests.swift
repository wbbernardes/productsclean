//
//  FetchProductsUseCaseTests.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import XCTest
import Combine
@testable import Domain

@available(iOS 15.0, *)
@available(macOS 10.15, *)
class FetchProductsUseCaseTests: XCTestCase {
    
    public enum APIError: Error {
        case badRequest // 400
        case unauthorized // 401
        case forbidden // 403
        case notFound // 404
        case serverError // 500
        case unknown
    }
    
    var productRepositoryMock: ProductRepositoryMock!
    var fetchProductsUseCase: FetchProductsUseCaseProtocol!

    override func setUp() {
        super.setUp()
        productRepositoryMock = ProductRepositoryMock()
        fetchProductsUseCase = FetchProductsUseCase(productRepository: productRepositoryMock)
    }

    override func tearDown() {
        productRepositoryMock = nil
        fetchProductsUseCase = nil
        super.tearDown()
    }
    
    func testFetchProductsUseCaseSuccess() async throws {
        // Given
        let expectedProducts = [Product(id: 1, title: "Test Product", price: 10.0, description: "This is a test product", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", category: "test")]
        productRepositoryMock.nextResult = .success(expectedProducts)

        // When
        let products = try await fetchProductsUseCase.execute()

        // Then
        XCTAssertEqual(products, expectedProducts)
    }

    func testFetchProductsUseCaseFailure() async {
        // Given
        let expectedError = APIError.serverError
        productRepositoryMock.nextResult = .failure(expectedError)

        // When
        do {
            _ = try await fetchProductsUseCase.execute()
            XCTFail("Expected failure, but got success instead")
        } catch {
            // Then
            XCTAssertTrue(error is APIError)
            XCTAssertEqual(error as? APIError, expectedError)
        }
    }
}
