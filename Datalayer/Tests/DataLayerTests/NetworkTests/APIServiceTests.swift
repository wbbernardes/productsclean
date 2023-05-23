//
//  APIServiceTests.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import XCTest
import Combine
@testable import DataLayer

final class APIServiceTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    var responseMock: HTTPURLResponse!
    var sessionMock: MockNetworkSession!
    var apiServiceMock: APIService!
    var json: Data!
    
    override func setUp() {
        super.setUp()
        json = """
        [{
            "id": 1,
            "title": "Test Product",
            "price": 10.0,
            "description": "This is a test product",
            "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            "category": "test"
        }]
        """.data(using: .utf8)!
        
        responseMock = HTTPURLResponse(url: URL(string: "https://fakestoreapi.com/products")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        sessionMock = MockNetworkSession(data: json, response: responseMock, error: nil)
        apiServiceMock = APIService(session: sessionMock)
    }
    
    override func tearDown() {
        json = nil
        responseMock = nil
        sessionMock = nil
        apiServiceMock = nil
        super.tearDown()
    }
    
    func testAPIServiceWithSuccess() async throws {
        // When
        let products: [ProductDTO] = try await apiServiceMock.request(.getProducts)
        
        // Then
        XCTAssertEqual(products.count, 1)
        XCTAssertEqual(products.first?.id, 1)
        XCTAssertEqual(products.first?.title, "Test Product")
    }
}
