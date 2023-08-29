//
//  FifthView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 28/08/23.
//

import SwiftUI

struct FifthView: View {
    var coordinator: ThirdCoordinator //this is for speed up the development
    
    var body: some View {
        VStack(spacing: 16) {
            Text("I'm a FifthView")
                .font(.title)
            
            Button {
                coordinator.sheetDismiss()
            } label: {
                Text("sheetDismiss")
            }
        }
        .onAppear {
            print("onAppear FifthView")
        }
        .onDisappear {
            print("onDisappear FifthView")
        }
        .navigationBarTitle(Text("FifthView"), displayMode: .inline)
    }
}
