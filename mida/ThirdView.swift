//
//  ThirdView.swift
//  mida
//
//  Created by Баэль Рыспеков on 10/6/24.
//

import SwiftUI

import SwiftUI

struct ThirdView: View {

    @StateObject private var viewModel: ViewModel
//    @EnvironmentObject var sharedData: SharedData
//    let sharedData: SharedData = .shared

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }

    @State private var carName: String = ""
    @State private var carDetails: String = ""

    var body: some View {
        VStack {
            TextField("Car Name", text: $carName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Car Details", text: $carDetails)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add Car") {
                let newCar = Car(name: carName, details: carDetails)
                viewModel.sharedData.addCar(newCar)
            }
            .padding()

            Button("Close") {
                viewModel.close()
            }
            .padding()
        }
    }
}


#Preview {
    ThirdView(viewModel: .init(isPresented: .constant(.random()), container: .init()))
}
