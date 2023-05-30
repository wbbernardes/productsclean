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
    @EnvironmentObject var coordinator: Coordinator<MapRouter>
    let product: Product
    
    var body: some View {
        VStack {
            Text(product.title)
                .font(.title)
            Text(product.description)
                .font(.body)
            
            Button {
                coordinator.pop()
            } label: {
                Text("back")
            }
            
            Button {
                coordinator.popToRoot()
            } label: {
                Text("poop to root")
            }
            
            Button {
                coordinator.dismiss()
            } label: {
                Text("dismiss")
            }
        }
        .onAppear {
            print("onAppear AnotherView")
        }
        .padding()
        .navigationBarTitle(Text("AnotherView"), displayMode: .inline)
    }
}
