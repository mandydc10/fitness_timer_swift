//
//  Exercise+CoreDataProperties.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 1/2/2025.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var duration: Double
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var workout: Workout?

}

extension Exercise : Identifiable {

}
