//
//  Workout+CoreDataClass.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 1/2/2025.
//
//

import Foundation
import CoreData

@objc(Workout)
public class Workout: NSManagedObject {

    public var wrappedWorkoutName: String {

        workout_name ?? "Unknown workout"
    }
        // Allow for foreach looping on NSSet
    public var exerciseArray: [Exercise] {
        let set = exercises as? Set<Exercise> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
}
