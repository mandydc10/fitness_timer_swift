//
//  DataController.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 28/1/2025.
//

import CoreData

struct PersistenceController {
    let container: NSPersistentContainer
    
    static let shared = PersistenceController()
    
    // Convenience
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Workouts
        let newWorkout = Workout(context: viewContext)
        newWorkout.workout_name = "Warm up"
        newWorkout.total_duration = 0
        newWorkout.workout_id = UUID()
        
        // Exercises
        let newExercise = Exercise(context: viewContext)
        newExercise.name = "Lunges"
        newExercise.duration = 30000
        newExercise.id = UUID()
//        newExercise.addToExercise(workout: newWorkout)
        
        shared.saveContext()
        
        return result
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ExerciseWorkoutModel")  // else UnsafeRawBufferPointer with negative count
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler:  { (storeDescription, error) in
            if let error = error as NSError? {
                print("Failed to load the exercise data \(error.localizedDescription)")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // Better save
    func saveContext() {
        print("Running save function")
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                print("In do")
                try context.save()
                print("In try")
                print("Data saved!!! Woohoo")
            } catch {
                // Handle errors in our database
                print("In catch")
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    
}
