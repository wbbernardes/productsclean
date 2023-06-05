//
//  OnboardingView.swift
//  ProductsClean
//
//  Created by Wesley Brito on 02/06/23.
//

import SwiftUI

struct OnboardingView: View {
    var coordinator: OnboardingCoordinator//this is for speed up the development
    
    var body: some View {
        VStack {
            Text("I'm a Onboarding")
                .font(.title)
            
            Button {
                coordinator.startTabFlow()
            } label: {
                Text("Go to tabFlow")
            }
        }
        .onAppear {
            print("onAppear OnboardingView")
        }
        .navigationBarTitle(Text("OnboardingView"), displayMode: .inline)
    }
}
