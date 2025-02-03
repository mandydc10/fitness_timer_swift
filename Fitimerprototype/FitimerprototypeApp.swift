//
//  FitimerprototypeApp.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 9/12/2024.
//

import SwiftUI

@main
struct FitimerprototypeApp: App {
    @Environment(\.scenePhase) var scenePhase // allows for saving data when app goes into the background, requires added .onChange from line 19
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }.onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }
    }
}
