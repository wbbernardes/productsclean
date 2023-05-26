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
    let product: Product
    
    var body: some View {
        ZStack {
            VStack {
                Text(product.title)
                    .font(.title)
                Text(product.description)
                    .font(.body)
            }
            .onTapGesture {
                envDetail.productDetailRouter = true
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
                destination: AnotherView(product: product),
                isActive: $envDetail.productDetailRouter
//                    Binding<Bool>(
//                    get: { envDetail.productDetailRouter == .anotherDetail },
//                    set: { _ in
//                        envDetail.productDetailRouter = .none
//                    }
//                )
            ) { EmptyView() }
        }
    }
}
