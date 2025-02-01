//
//  DataController.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 1/2/2025.
//

//import UIKit
import SwiftUI
import CoreData

class DataController: ObservableObject {
    @Environment(\.managedObjectContext) private var viewContext
    
    func addExercise(name: String, duration: Double, workout: Workout, context: NSManagedObjectContext) {
        print("Running add exercise")
        let newExercise = Exercise(context: context)
        newExercise.id = UUID()
        newExercise.name = name
        newExercise.duration = duration
        
        workout.addToExercises(newExercise)
        
        print("exercise id: \(newExercise.id!) exercise name: \(newExercise.name!) exercise duration: \(newExercise.duration)")
        PersistenceController().saveContext()
    }
    
    func editExercise(exercise: Exercise, name: String, duration: Double, context: NSManagedObjectContext) {
        exercise.name = name
        exercise.duration = duration
        
        PersistenceController().saveContext()
    }
    
    func addWorkout(name: String, duration: Double, context: NSManagedObjectContext) {
        let workout = Workout(context: context)
        workout.workout_id = UUID()
        workout.workout_name = name
        workout.total_duration = duration
        
        PersistenceController().saveContext()
    }
    
    func editWorkout(workout: Workout, name: String, duration: Double, context: NSManagedObjectContext) {
        workout.workout_name = name
        workout.total_duration = duration
        
        PersistenceController().saveContext()
    }
}
