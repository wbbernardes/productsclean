//
//  APITarget.swift
//
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation

public enum APITarget {
    case getProducts
    
    var baseURL: URL {
        return URL(string: "https://fakestoreapi.com")!
    }

    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        }
    }

    var method: String {
        switch self {
        case .getProducts:
            return "GET"
        }
    }

    var task: [String: Any] {
        switch self {
        case .getProducts:
            return [:] // For GET requests there's usually no body
        }
    }

    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }

    var url: URL {
        return baseURL.appendingPathComponent(path)
    }
}
