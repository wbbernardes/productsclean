//
//  CoreDataStack.swift
//  
//
//  Created by Wesley Brito on 18/06/23.
//

import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    private let modelName: String = "DataLayerDB"
    
    lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle.module.url(forResource: modelName, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            return NSPersistentContainer()
        }
        
        let container = NSPersistentContainer(name: modelName, managedObjectModel: model)

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

