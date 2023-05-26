//
//  ProductsView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 21/05/23.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject private var envApp: EnvApp
    @StateObject var viewModel: ProductsViewModel

    init(viewModel: ProductsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
                List {
                    ForEach(viewModel.products) { product in
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                            Text(product.description)
                                .font(.subheadline)
                            Text("Price: \(product.price)")
                                .font(.caption)
                        }
                        .onTapGesture {
                            viewModel.selectedProduct = product
                            envApp.productRouter = true
                        }
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.fetchProducts()
                    }
                }
                .navigationTitle("Products")
                .background(navigationLinks)
        }
    }
    
    var navigationLinks: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: ProductDetailView(product: viewModel.selectedProduct),
                isActive: $envApp.productRouter
            ) { EmptyView() }
        }
    }
}
