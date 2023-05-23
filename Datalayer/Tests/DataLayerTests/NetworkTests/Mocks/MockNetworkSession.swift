//
//  MockNetworkSession.swift
//
//
//  Created by Wesley Brito on 21/05/23.
//

import Combine
import Foundation
@testable import DataLayer

struct MockNetworkSession: NetworkSession {
    let data: Data
    let response: URLResponse
    let error: URLError?
    
    func customDataTaskPublisher(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        } else {
            return (data, response)
        }
    }
}
