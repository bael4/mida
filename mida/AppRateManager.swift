import SwiftUI
import StoreKit

class ReviewRequestManager: ObservableObject {
    @AppStorage("lastReviewRequestDate") private var lastReviewRequestDate: String?
    @AppStorage("reviewRequestCount") private var reviewRequestCount: Int = 0
    
    var isSessionActive: Bool = false {
        didSet {
            if isSessionActive {
                startSessionTimer()
            } else {
                endSessionTimer()
            }
        }
    }
    
    private var sessionTimer: Timer?
    
    func requestReviewIfNeeded() {
        let now = Date()
        let calendar = Calendar.current
        
        // Проверить, если дата последнего запроса существует
        if let lastRequestDateString = lastReviewRequestDate,
           let lastRequestDate = DateFormatter.appStorageDateFormatter.date(from: lastRequestDateString) {
            
            // Вычислить разницу в месяцах между текущим и последним запросом
            let monthsDifference = calendar.dateComponents([.month], from: lastRequestDate, to: now).month ?? 0
            
            // Если прошло меньше месяца с последнего запроса, выход
            if monthsDifference < 1 {
                print("Not enough time has passed since the last review request.")
                return
            }
        }

        // Проверить количество запросов в текущем году
        if reviewRequestCount < 3 {
            requestReview()
            lastReviewRequestDate = DateFormatter.appStorageDateFormatter.string(from: now)
            reviewRequestCount += 1
        } else {
            print("You've already requested reviews 3 times this year.")
        }
    }

    private func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }

    private func startSessionTimer() {
        sessionTimer = Timer.scheduledTimer(withTimeInterval: 5 * 2, repeats: true) { [weak self] timer in
            // Вызывать requestReviewIfNeeded после 5 минут активной сессии
            self?.requestReviewIfNeeded()
            self?.isSessionActive = false
        }
    }

    private func endSessionTimer() {
        sessionTimer?.invalidate()
        sessionTimer = nil
    }

}

extension DateFormatter {
    static let appStorageDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
}

