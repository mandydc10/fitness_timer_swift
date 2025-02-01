//
//  Workout+CoreDataProperties.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 1/2/2025.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var total_duration: Double
    @NSManaged public var workout_id: UUID?
    @NSManaged public var workout_name: String?
    @NSManaged public var exercises: NSSet? // important to address this and create array in class file to allow for looping

}

// MARK: Generated accessors for exercises
extension Workout {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}

extension Workout : Identifiable {
// important for allowing foreach in swift ui
}
