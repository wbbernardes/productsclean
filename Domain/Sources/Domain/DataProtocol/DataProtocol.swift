//
//  File.swift
//  
//
//  Created by Wesley Brito on 18/06/23.
//

import Foundation

public protocol ProductRepositoryProtocol {
    func fetchProducts() async throws -> [Product]
}
