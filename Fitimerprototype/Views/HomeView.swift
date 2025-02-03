//
//  ContentView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 9/12/2024.
//

import SwiftUI
import UIKit
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.workout_name)]) var workout: FetchedResults<Workout>

    @State private var workoutName: String = ""
    @State private var showingAddAlert = false
    
    @State var selectedTab: Tabs = .workouts

    
    var body: some View {
        
        VStack {
            if selectedTab == .workouts {
                WorkoutListView()
            } else if selectedTab == .exercises {
                    ExerciseLibraryView()
            }
            else if selectedTab == .timer {
                QuickTimerView(remainingSecs: 00, remainingMins: 00)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //        ContentView()
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
