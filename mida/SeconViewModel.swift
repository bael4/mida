//
//  SeconViewViewModel.swift
//  mida
//
//  Created by Баэль Рыспеков on 10/6/24.
//

import SwiftUI
import Swinject

extension SecondView {
    @MainActor
    class ViewModel: ObservableObject {
        
        private let container: Container
        
        @Binding private var openSecondView: Bool
        @Published private var openThirdView: Bool = false
        

        private(set) lazy var presentedBinding: Binding<Bool> = {
            Binding(
                get: { [weak self] in self?.openThirdView ?? false },
                set: { [weak self] in self?.openThirdView = $0 }
            )
        }()

        init(openSecondView: Binding<Bool>, container: Container) {
            self._openSecondView = openSecondView
            self.container = container
        }

        func close() {
            openSecondView = false
        }

        func open() {
            openThirdView = true
        }

        func makeThirdViewModel() -> ThirdView.ViewModel {
            return .init(isPresented: presentedBinding, container: container)
        }

    }
}
