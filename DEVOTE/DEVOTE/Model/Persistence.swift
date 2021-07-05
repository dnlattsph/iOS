//
//  Persistence.swift
//  DEVOTE
//
//  Created by D Naung Latt on 02/07/2021.
//

import CoreData

struct PersistenceController {
    // MARK 1. PERSISTENCE CONTROLLER
    static let shared = PersistenceController()

    // MARK 2. PERSISTENCE CONTAINER
    let container: NSPersistentContainer
    
    // MARK 3. INIT (Load the persisten store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DEVOTE")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK 4. PREVIEW
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "Sample Task No\(i)"
            newItem.completion = false
            newItem.id = UUID()
            
        }
        do {
            try viewContext.save()
        } catch {
            
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
