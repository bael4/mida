//
//  NewView.swift
//  mida
//
//  Created by Баэль Рыспеков on 10/6/24.
//

import SwiftUI

struct NewView: View {

    @ObservedObject private var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        _viewModel =  ObservedObject(wrappedValue: viewModel())
    }

    var body: some View {

        ScrollView {
            
            VStack {
                List {
                    ForEach(viewModel.sharedData.cars) { car in
                        VStack(alignment: .leading) {
                            Text(car.name)
                                .font(.headline)
                            Text(car.details)
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: viewModel.sharedData.deleteCar)
               
                }
                
              
                Button("Button") {
                    viewModel.open()
                }
                
            }.fullScreenCover(isPresented: viewModel.presentedBinding, content: {
                SecondView(viewModel: viewModel.makeSecondViewModel())
            })
            
        }

    }

}

#Preview {
    NewView(viewModel: .init(container: .mock))
}
