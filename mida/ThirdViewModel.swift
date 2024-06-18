//
//  ThirdViewModel.swift
//  mida
//
//  Created by Баэль Рыспеков on 10/6/24.
//

import SwiftUI
import Swinject

extension ThirdView {
    @MainActor
    class ViewModel: ObservableObject {
        
        private let container: Container
        let sharedData: SharedData
        @Binding private var isPresented: Bool

        init(isPresented: Binding<Bool>, container: Container) {
            self._isPresented = isPresented
            self.container = container
            self.sharedData = container.resolve(SharedData.self)!
        }

        func close() {
            isPresented = false
        }

    }
}
