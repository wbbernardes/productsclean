//
//  ProductDetailView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 24/05/23.
//

import SwiftUI
import Domain //this is for speed up the development

struct ProductDetailView: View {
    @StateObject var viewModel: ProductDetailViewModel
    
    init(viewModel: ProductDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(viewModel.product.title)
                    .font(.title)
                Text(viewModel.product.description)
                    .font(.body)
                
                Button {
                    viewModel.openThirdFlow()
                } label: {
                    Text("NAVIGATE to Third Child")
                }
                .padding(.top, 32)
            }
            .onAppear {
                print("onAppear ProductDetailView")
            }
            .navigationBarTitle(Text("ProductDetailView"), displayMode: .inline)
        }
        
    }
}
