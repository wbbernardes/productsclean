//
//  ProductDetailView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 24/05/23.
//

import SwiftUI
import Domain

struct ProductDetailView: View {
    @StateObject private var envDetail: EnvDetail = EnvDetail()
    @EnvironmentObject var coordinator: Coordinator<MapRouter>
    let product: Product
    
    var body: some View {
        ZStack {
            VStack {
                Text(product.title)
                    .font(.title)
                Text(product.description)
                    .font(.body)
                
                Button {
                    envDetail.productDetailRouter = true
//                    coordinator.show(.another(product: product))
                } label: {
                    Text("Test")
                }

            }
            .onAppear {
                print("onAppear ProductDetailView")
            }
            .padding()
            .navigationBarTitle(Text("ProductDetailView"), displayMode: .inline)
            .background(navigationLinks)
        }
        
    }
    
    var navigationLinks: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: AnotherView(product: product).environmentObject(coordinator),
                isActive: $envDetail.productDetailRouter
            ) { EmptyView() }
        }
    }
}
