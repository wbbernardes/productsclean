//
//  FavoriteView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 01/06/23.
//

import SwiftUI

struct FavoriteView: View {
    var coordinator: FavoriteCoordinator//this is for speed up the development
    
    var body: some View {
        VStack {
            Text("I'm a Favorite Tab")
                .font(.title)
            
//            Button {
////                coordinator.navigationController.popViewController(animated: true)
//            } label: {
//                Text("back")
//            }
            
            Button {
                coordinator.popToOnboard()
            } label: {
                Text("poop to Onboarding")
            }
            .padding(.top, 16)
        }
        .onAppear {
            print("onAppear FavoriteView")
        }
        .navigationBarTitle(Text("FavoriteView"), displayMode: .inline)
    }
}
