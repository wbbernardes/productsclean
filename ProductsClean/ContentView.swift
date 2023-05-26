//
//  ContentView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 20/05/23.
//

import SwiftUI

//struct ContentView: View {
//    @EnvironmentObject var envApp: EnvApp
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                ForEach(envApp.router.indices, id:\.self) { index in
//                    switch envApp.router[index] {
//                    case .products:
//                        NavigationLink(destination: ProductsView(viewModel: ProductsFactory.makeProductsViewModel()), isActive: .constant(true)) { EmptyView() }
//                    case let .productsDetail(product):
//                        NavigationLink(destination: ProductDetailView(product: product), isActive: .constant(true)) { EmptyView() }
//                    case let .anotherDetail(product):
//                        NavigationLink(destination: AnotherView(product: product), isActive: .constant(true)) { EmptyView() }
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
