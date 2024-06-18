//
//  SecondView.swift
//  mida
//
//  Created by Баэль Рыспеков on 10/6/24.
//

import SwiftUI

struct SecondView: View {
    @StateObject private var viewModel: ViewModel
//    @EnvironmentObject var sharedData: SharedData
    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        VStack {

            Text("Hello, World!")

            Button("Button open") {
                viewModel.open()
            }

            Button("Button close") {
                viewModel.close()
            }

        }.fullScreenCover(isPresented: viewModel.presentedBinding, content: {
            ThirdView(viewModel: viewModel.makeThirdViewModel())
//                .environmentObject(sharedData)
        })
    }

}

#Preview {
    SecondView(viewModel: .init(openSecondView: .constant(.random()), container: .init()))
}
