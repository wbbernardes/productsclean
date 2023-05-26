//
//  AnotherView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 24/05/23.
//

import SwiftUI
import Domain

struct AnotherView: View {
    @EnvironmentObject private var envApp: EnvApp
    let product: Product
    
    var body: some View {
        VStack {
            Text(product.title)
                .font(.title)
            Text(product.description)
                .font(.body)
                .onTapGesture {
                    envApp.productRouter = false
                }
        }
        .onAppear {
            print("onAppear AnotherView")
        }
        .padding()
        .navigationBarTitle(Text("AnotherView"), displayMode: .inline)
    }
}
