//
//  CoreDataHandler.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 15/08/24.
//

import Foundation
import CoreData
class CoreDataHandler {
    static let shared = CoreDataHandler()
    private let persistentContainerName: String = "DataCachingDataModel"
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("error: \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveData() {
        guard viewContext.hasChanges else {return}
        do {
            try viewContext.save()
        } catch {
            fatalError("Error Saving data")
        }
    }
    func fetchData<T: NSManagedObject>(request :NSFetchRequest<T>) -> [T]{
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
