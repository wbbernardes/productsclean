//
//  Product.swift
//  
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation

public struct Product: Equatable, Hashable, Identifiable {
    public let id: Int
    public let title: String
    public let price: Double
    public let description: String
    public let image: String
    public let category: String
    
    public init(id: Int, title: String, price: Double, description: String, image: String, category: String) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.image = image
        self.category = category
    }
}
