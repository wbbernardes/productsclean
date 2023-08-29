//
//  FourthView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 28/08/23.
//

import SwiftUI

struct FourthView: View {
    weak var coordinator: ThirdCoordinator? //this is for speed up the development
    
    var body: some View {
        VStack(spacing: 16) {
            Text("I'm a Third and a \nChild of Products Coordinator")
                .font(.title)
            
            Button {
                coordinator?.dismissFourthView()
            } label: {
                Text("dismiss FourthView")
            }
        }
        .onAppear {
            print("onAppear FourthView")
        }
        .onDisappear {
            print("onDisappear FourthView")
        }
        .navigationBarTitle(Text("FourthView"), displayMode: .inline)
    }
}
