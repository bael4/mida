//
//  SharedData.swift
//  mida
//
//  Created by Баэль Рыспеков on 10/6/24.
//

import Foundation
import Combine

struct Car: Identifiable, Codable {
    var id: UUID = .init()
    var name: String
    var details: String
}

class SharedData: ObservableObject {
    static let shared = SharedData()
    @Published var cars: [Car] = []

    private let fileURL: URL

  private init() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        fileURL = paths[0].appendingPathComponent("cars.json")

        loadCars()
    }

    func addCar(_ car: Car) {
        cars.append(car)
        saveCars()
    }

    func deleteCar(at offsets: IndexSet) {
        cars.remove(atOffsets: offsets)
        saveCars()
    }

    private func saveCars() {
        do {
            let data = try JSONEncoder().encode(cars)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save cars: \(error.localizedDescription)")
        }
    }

    private func loadCars() {
        do {
            let data = try Data(contentsOf: fileURL)
            cars = try JSONDecoder().decode([Car].self, from: data)
        } catch {
            print("Failed to load cars: \(error.localizedDescription)")
        }
    }
}

