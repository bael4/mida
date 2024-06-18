//
//  midaApp.swift
//  mida
//
//  Created by Баэль Рыспеков on 5/6/24.
//

import SwiftUI
import Swinject

@main
struct midaApp: App {
//    @StateObject private var sharedData: SharedData = SharedData()

    @StateObject private var sessionTimer = SessionManager()
    
    @StateObject private var reviewRequestManager = ReviewRequestManager()
    
    private let container: Container = {
        let container = Container()

        container.register(SharedData.self) { _ in return .shared }
       
        return container
    }()

    var body: some Scene {

        WindowGroup {

            NextView()
                .environmentObject(reviewRequestManager)
                .onAppear {
                    reviewRequestManager.isSessionActive = true
                }
                
        }
    }
    
    

}

extension Container {
    /// Заглушка контейнера для работы Previews.
    static let mock: Container = {
        let container = Container()
    
        container.register(SharedData.self) { _ in return .shared }
        
        return container
    }()
}
