//
//  ProductDetailView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 24/05/23.
//

import SwiftUI
import Domain //this is for speed up the development

struct ProductDetailView: View {
    let product: Product
    let coordinator: ProductsCoordinator//this is for speed up the development
    
    var body: some View {
        ZStack {
            VStack {
                Text(product.title)
                    .font(.title)
                Text(product.description)
                    .font(.body)
                
                Button {
                    coordinator.startThirdFlow()
                } label: {
                    Text("NAVIGATE to Third Child")
                }
            }
            .onAppear {
                print("onAppear ProductDetailView")
            }
            .navigationBarTitle(Text("ProductDetailView"), displayMode: .inline)
        }
        
    }
}
