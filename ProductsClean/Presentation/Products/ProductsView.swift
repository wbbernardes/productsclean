//
//  ProductsView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 21/05/23.
//

import SwiftUI

struct ProductsView: View {
    @StateObject var viewModel: ProductsViewModel

    init(viewModel: ProductsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if let error = viewModel.error {
                Text(error.localizedDescription)
            } else {
                List(viewModel.products, id: \.self) { product in
                    VStack(alignment: .leading) {
                        Text(product.title)
                            .font(.headline)
                        Text(product.description)
                            .font(.subheadline)
                        Text("Price: \(product.price)")
                            .font(.caption)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchProducts()
            }
        }
    }
}
