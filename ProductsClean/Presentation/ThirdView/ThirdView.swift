//
//  ThirdView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 01/06/23.
//

import SwiftUI

struct ThirdView: View {
    var coordinator: ThirdCoordinator//this is for speed up the development
    
    var body: some View {
        VStack {
            Text("I'm a Third and a \nChild of Products Coordinator")
                .font(.title)
            
            Button {
                coordinator.parentCoordinator?.switchToSecondTab()
            } label: {
                Text("Change to favorite")
            }
            
            Button {
                coordinator.parentCoordinator?.navigationController.popToRootViewController(animated: true)
            } label: {
                Text("poop to root")
            }
        }
        .onAppear {
            print("onAppear ThirdView")
        }
        .navigationBarTitle(Text("ThirdView"), displayMode: .inline)
    }
}
