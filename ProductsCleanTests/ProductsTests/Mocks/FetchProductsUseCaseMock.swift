//
//  FetchProductsUseCaseMock.swift
//  ProductsCleanTests
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation
import Domain

class FetchProductsUseCaseMock: FetchProductsUseCaseProtocol {
    var result: Result<[Product], Error>!
    
    func execute() async throws -> [Product] {
        switch result {
        case .success(let products):
            return products
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result was not set. You might have forgotten to set the result in your test case.")
        }
    }
}
