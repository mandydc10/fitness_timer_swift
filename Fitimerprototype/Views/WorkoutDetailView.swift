//
//  SingleWorkoutView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 29/1/2025.
//

import SwiftUI
import UIKit
import CoreData

struct WorkoutDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    @StateObject var workout: Workout
    @State private var showAddView = false
    
//    var workout: FetchedResults<Workout>.Element
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var exercise: FetchedResults<Exercise>
    
    var body: some View {
            NavigationStack {
                VStack(alignment: .leading) {
                    Text("\(totalDuration()) total duration")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    NavigationLink(destination: TimerView(workout: workout)) {
//                        Text("Start workout")
//                            .font(.title)
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 80, weight: .medium, design: .rounded))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    
                    
                    Button("Add New Exercise") {
                        // Toggle AddExerciseView bool to initiate sheet popup
                        showAddView.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(20)
                    
                    List {
                        ForEach(workout.exerciseArray) { exercise in
                            NavigationLink(destination: EditExerciseView(exercise: exercise)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(exercise.wrappedName)
                                            .bold()
                                        Text("\(formatMinSecString(durationMS: exercise.duration))")
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            
                        }
                        .onDelete(perform: deleteExercise)
                        
                        
                    }
                    .listStyle(.plain)
                    
                    Spacer()
                    
                    
                }
//                .navigationTitle(workout.wrappedWorkoutName)
                
                .sheet(isPresented: $showAddView) {
                    AddExerciseView(workout: workout)
                }
                
            }
            .navigationTitle(workout.wrappedWorkoutName)
            .toolbar {
//                    ToolbarItem(placement: .navigationBar ) {
//                        Button {
//                            // TODO
////                            showingAddView.toggle()
//                        } label: {
//                            Label("Profile", systemImage: "person.crop.circle")
//                        }
//                    }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EditWorkoutNameView(workout: workout)) {
                        Text("Edit")
                    }
                }
            }
        }
    
    private func deleteExercise(offsets:IndexSet) {
        withAnimation {
            offsets.map { exercise[$0] }
                .forEach(viewContext.delete)
            
//          Saves to our database
            PersistenceController.shared.saveContext()
        }
    }
    
    private func totalDuration() -> String {
        var totalTime : Double = 0
        
        
        for item in workout.exerciseArray {
            print(item)
            totalTime += item.duration
        }
        
        let formattedTime = formatMinSecHrString(durationMS: totalTime)

        print("Total workout time: \(formattedTime)")
        return formattedTime
    }
}
    
struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newWorkout = Workout(context: viewContext)
        newWorkout.workout_name = "Warm up"
        newWorkout.workout_id = UUID()
        
        let exercise1 = Exercise(context: viewContext)
        exercise1.name = "Jogging"
        exercise1.id = UUID()
        exercise1.duration = 20000
        let exercise2 = Exercise(context: viewContext)
        exercise2.name = "Skipping"
        exercise2.id = UUID()
        exercise2.duration = 120000
        
        newWorkout.addToExercises(exercise1)
        newWorkout.addToExercises(exercise2)
        
        return WorkoutDetailView(workout: newWorkout).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//        SingleWorkoutView(workout: workout)
    }
}

