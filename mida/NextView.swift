//
//  NextView.swift
//  mida
//
//  Created by Баэль Рыспеков on 15/6/24.
//

import SwiftUI

struct NextView: View {

    @EnvironmentObject var reviewRequestManager: ReviewRequestManager
    
    var body: some View {
        
        NavigationView {
            ScrollView {

                Button("Rate") {
                    reviewRequestManager.requestReviewIfNeeded()
                }

              
                
                GroupBox(label: Label("Settings", systemImage: "gear")) {
                    Toggle("private account", isOn: .constant(.random()))
                    Toggle("save", isOn: .constant(false))
                }
                .padding()
                
                NavigationLink {
                    NewView(viewModel: .init(container: .mock))
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Button")
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .scaleEffect(1)
                }

                
                
               
                
                
            }
        }
    }

}

#Preview {
    NextView()
}
