//
//  File.swift
//  mida
//
//  Created by Баэль Рыспеков on 17/6/24.
//

import SwiftUI
import Combine

final class SessionManager: ObservableObject {
    @Published var startTime: Date?
    @Published var timeSpent: TimeInterval = 0
    private var timer: AnyCancellable?
    
    func startSession() {
        startTime = Date()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimeSpent()
            }
    }
    
    func endSession() {
        timer?.cancel()
        updateTimeSpent()
    }
    
    private func updateTimeSpent() {
        if let startTime = startTime {
            timeSpent = Date().timeIntervalSince(startTime)
        }
    }
    
    func hasSpentMoreThanFiveMinutes() -> Bool {
        return timeSpent > 300 // 300 секунд = 5 минут
    }

}
