//
//  APIServiceMock.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import Combine
@testable import DataLayer

class APIServiceMock: APIServiceProtocol {
    
    var nextResult: Result<[ProductDTO], APIError> = .success([])
    
    func request<T>(_ target: APITarget) async throws -> T where T : Decodable {
        switch self.nextResult {
        case .success(let products):
            return products as! T
        case .failure(let error):
            throw error
        }
    }
}
