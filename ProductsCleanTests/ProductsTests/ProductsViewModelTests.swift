//
//  ProductsViewModelTests.swift
//  ProductsCleanTests
//
//  Created by Wesley Brito on 21/05/23.
//

import XCTest
@testable import ProductsClean
import Domain
import DataLayer

class ProductsViewModelTests: XCTestCase {
    
    var fetchProductsUseCaseMock: FetchProductsUseCaseMock!
    var viewModel: ProductsViewModel!
    
    override func setUp() {
        super.setUp()
        fetchProductsUseCaseMock = FetchProductsUseCaseMock()
        viewModel = ProductsViewModel(fetchProductsUseCase: fetchProductsUseCaseMock)
    }
    
    override func tearDown() {
        fetchProductsUseCaseMock = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchProductsSuccess() async throws {
        // Given
        let expectedProducts = [Product(id: 1, title: "Test Product", price: 10.0, description: "This is a test product", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", category: "test")]
        fetchProductsUseCaseMock.result = .success(expectedProducts)
        
        // When
        await viewModel.fetchProducts()
        
        // Wait for a brief moment to let the fetch operation finish
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Then
        XCTAssertEqual(viewModel.products, expectedProducts)
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchProductsFailure() async throws {
        // Given
        let expectedError = APIError.serverError
        fetchProductsUseCaseMock.result = .failure(expectedError)
        
        // When
        await viewModel.fetchProducts()
        
        // Wait for a brief moment to let the fetch operation finish
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Then
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error as? APIError, expectedError)
    }
}
