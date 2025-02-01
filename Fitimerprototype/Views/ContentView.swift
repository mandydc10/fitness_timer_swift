//
//  ContentView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 9/12/2024.
//

import SwiftUI
import UIKit
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.workout_name)]) var workout: FetchedResults<Workout>

    @State private var workoutName: String = ""
    @State private var showingAddAlert = false

    
    var body: some View {
            NavigationView {
                VStack(alignment: .leading) {
                    List {
                        ForEach(workout) { workout in
                            NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Spacer()
                                        Text(workout.workout_name ?? "")
                                            .bold()
                                        Spacer()
                                        Text("\(Int(workout.total_duration))").foregroundColor(.gray)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteWorkout)
                    }
                    .listStyle(.plain)
                    Spacer()
                }
                .navigationTitle("My Workouts")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddAlert.toggle()
                        } label: {
                            Label("Add workout", systemImage: "plus.circle")
                        }
                        .alert("New Workout", isPresented: $showingAddAlert) {
                            TextField("Enter workout name", text: $workoutName)
                            Button("Add Workout", action: addWorkout)
                            Button("Cancel", role: .cancel) { }
                        }
//                    message: {
//                            Text("Add workout name")
//                        }
                        .accessibilityLabel("Add new workout")
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
            }
            .navigationViewStyle(.stack)
        }
        
        private func deleteWorkout(offsets:IndexSet) {
            withAnimation {
                offsets.map { workout[$0] }
                    .forEach(viewContext.delete)
                
                // Save to database
                PersistenceController.shared.saveContext()
            }
        }
    
    private func addWorkout() {
        withAnimation {
            let newWorkout = Workout(context: viewContext)
            newWorkout.workout_name = workoutName
            newWorkout.workout_id = UUID()
            
            // Save to database
            PersistenceController.shared.saveContext()
        }
    }
        
        //    private func totalDuration() -> Double {
        //        var totalTime : Double = 0
        //
        //        for item in workout {
        //            totalTime += item.total_duration
        //        }
        //        print("Total workout time: \(totalTime)")
        //        return totalTime
        //    }
            
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
