//
//  ThirdView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 01/06/23.
//

import SwiftUI

struct ThirdView: View {
    weak var coordinator: ThirdCoordinator? //this is for speed up the development
    
    var body: some View {
        VStack(spacing: 16) {
            Text("I'm a Third and a \nChild of Products Coordinator")
                .font(.title)
            
            Button {
                coordinator?.switchTab()
            } label: {
                Text("Change to favorite")
            }
            
            Button {
                coordinator?.popToRoot()
            } label: {
                Text("poop to root")
            }
            
            Button {
                coordinator?.popToSpecificVC()
            } label: {
                Text("popToSpecificViewController")
            }
            
            Button {
                coordinator?.popToOnboarding()
            } label: {
                Text("pop to onboarding")
            }
            
            Button {
                coordinator?.presentFourthView()
            } label: {
                Text("Present FourthView")
            }
            .foregroundColor(.orange)
            
            Button {
                coordinator?.sheetFifthView()
            } label: {
                Text("Sheet FifthView")
            }
            .foregroundColor(.red)
        }
        .onAppear {
            print("onAppear ThirdView")
        }
        .navigationBarTitle(Text("ThirdView"), displayMode: .inline)
    }
}
