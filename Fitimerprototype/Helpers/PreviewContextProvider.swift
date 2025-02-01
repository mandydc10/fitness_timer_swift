//
//  PreviewContextProvider.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 31/1/2025.
//

import CoreData

//struct PreviewContextProvider {
//    static let shared = PreviewContextProvider()
//
//    let container: NSPersistentContainer
//
//    private init() {
//        container = NSPersistentContainer(name: "ExerciseWorkoutModel") // Replace with your actual Core Data model name
//        let description = container.persistentStoreDescriptions.first
//        description?.url = URL(fileURLWithPath: "/dev/null") // Use in-memory storage
//        container.loadPersistentStores { _, error in
//            if let error = error {
//                fatalError("Failed to load Core Data stack: \(error)")
//            }
//        }
//    }
//
//    var viewContext: NSManagedObjectContext {
//        return container.viewContext
//    }
//}
