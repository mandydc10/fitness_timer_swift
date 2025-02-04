//
//  WorkoutListView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 2/2/2025.
//

import SwiftUI
import UIKit
import CoreData

struct WorkoutListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch workout model instances
    @FetchRequest(sortDescriptors: [SortDescriptor(\.workout_name)]) var workout: FetchedResults<Workout>

    @State private var workoutName: String = ""
    @State private var showAddView = false

    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                
                Spacer()
                
                Button("Add New Workout") {
                    // Toggle AddWorkoutView bool to initiate sheet popup
                    showAddView.toggle()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                
                List {
                    ForEach(workout) { workout in
                        NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Spacer()
                                    Text(workout.workout_name ?? "")
                                        .bold()
                                    Text("Total duration: \(formatMinSecHrString(durationMS: workout.total_duration))").foregroundColor(.gray)
                                        .padding()
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
            .padding(.bottom, 40)
            .navigationTitle("My Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddView) { AddWorkoutView()
                    .presentationDetents([.fraction(0.3)])
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
}


struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
