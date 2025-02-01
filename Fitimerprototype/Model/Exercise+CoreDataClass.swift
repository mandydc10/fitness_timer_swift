//
//  Exercise+CoreDataClass.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 1/2/2025.
//
//

import Foundation
import CoreData

@objc(Exercise)
public class Exercise: NSManagedObject {

    public var wrappedName: String {
        name ?? "Unknown exercise"
    }
    
}
