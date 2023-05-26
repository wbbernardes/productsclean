//
//  ProductsCleanApp.swift
//  ProductsClean
//
//  Created by Wesley Brito on 20/05/23.
//

import SwiftUI

@main
struct ProductsCleanApp: App {
    @StateObject private var envApp: EnvApp = EnvApp()
    @StateObject private var envDetail: EnvDetail = EnvDetail()
    
    var body: some Scene {
        WindowGroup {
            ProductsView(viewModel: ProductsFactory.makeProductsViewModel())
                .environmentObject(envApp)
                .environmentObject(envDetail)
            
//            ContentView()
//                .environmentObject(envApp)
        }
    }
}
