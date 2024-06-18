//
//  NewViewModel.swift
//  mida
//
//  Created by Баэль Рыспеков on 10/6/24.
//

import SwiftUI
import Swinject

extension NewView {
    @MainActor
    class ViewModel: ObservableObject {
        
        private let container: Container
        var sharedData: SharedData
        
        @Published private var openSecondView: Bool = false
        // Binding for presenting sheet
        private(set) lazy var presentedBinding: Binding<Bool> = {
            Binding(
                get: { [weak self] in self?.openSecondView ?? false },
                set: { [weak self] newValue in self?.openSecondView = newValue }
            )
        }()

        init(container: Container) {
            self.container = container
            self.sharedData = container.resolve(SharedData.self)!
        }

        // Open method
        func open() {
            openSecondView = true
        }

        // Creates SecondView ViewModel
        func makeSecondViewModel() -> SecondView.ViewModel {
            .init(openSecondView: presentedBinding, container: container)
        }
    }
}
