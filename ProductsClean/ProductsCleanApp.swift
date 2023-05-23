//
//  ProductsCleanApp.swift
//  ProductsClean
//
//  Created by Wesley Brito on 20/05/23.
//

import SwiftUI

@main
struct ProductsCleanApp: App {
    var body: some Scene {
        WindowGroup {
            ProductsView(factory: ProductsFactory().makeProductsViewModel())
        }
    }
}
