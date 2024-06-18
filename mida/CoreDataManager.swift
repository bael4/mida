//
//  CoreDataManager.swift
//  mida
//
//  Created by Баэль Рыспеков on 12/6/24.
//


import Foundation
import CoreData
import SwiftUI

class CoreDataManager: NSObject, ObservableObject {
    
    static let shared = CoreDataManager()
    
    private let context: NSManagedObjectContext
    
//    @Published var items: [ImagePathModel] = []
    
    private override init() {

        context = {
            let container = NSPersistentContainer(name: "ImagePath")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container.viewContext
        }()
        
    }
    
    private func saveContext() {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func saveImage(id: String) {
        
        let item = ImagePathModel(context: context)
        item.id = id
        
        saveContext()
    }
    
    func removeImage(id: String) {

        @FetchRequest(sortDescriptors: []) var items: FetchedResults<ImagePathModel>

        if let selectedImage = items.first(where: { $0.id == id })  {
            context.delete(selectedImage)
        }

        saveContext()

    }

    func fetchAll() -> [ImagePathModel] {
        
        let request = NSFetchRequest<ImagePathModel>(entityName: "ImagePathModel")
        
        do {
            let news = try context.fetch(request)
            return news
        } catch {
            print("Failed to fetch news: \(error)")
            return []
        }

      }

}
