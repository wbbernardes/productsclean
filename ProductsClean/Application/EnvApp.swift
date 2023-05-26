//
//  EnvApp.swift
//  ProductsClean
//
//  Created by Wesley Brito on 24/05/23.
//

import Combine
import Foundation

class EnvApp: ObservableObject {
    enum ProductsRouter {
        case productsDetail
        case none
    }
    
//    enum ProductsDetailRouter {
//        case anotherDetail
//        case none
//    }
    static let shared: EnvApp = EnvApp()
    
    @Published var productRouter: Bool = false
//    @Published var productDetailRouter: ProductsDetailRouter = .none
    
}

class EnvDetail: ObservableObject {
    enum ProductsDetailRouter {
        case anotherDetail
        case none
    }

    static let shared: EnvDetail = EnvDetail()

    @Published var productDetailRouter: Bool = false
}
