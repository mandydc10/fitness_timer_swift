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
    @State private var showingAddView = false
    
//    var workout: FetchedResults<Workout>.Element
//    print(workout.exerciseArray)
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var exercise: FetchedResults<Exercise>
    
    var body: some View {
        TabView {
            NavigationView {
                VStack(alignment: .leading) {
                    Text("\(totalDuration()) total duration")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    List {
                        ForEach(workout.exerciseArray) { exercise in
                            NavigationLink(destination: EditExerciseView(exercise: exercise)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Spacer()
                                        Text(exercise.wrappedName)
                                            .bold()
                                        Spacer()
                                        Text("\(formatMinSecString(durationMS: exercise.duration))")
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteExercise)
                    }
                    .listStyle(.plain)
                    Spacer()
                    NavigationLink(destination: TimerView(workout: workout)) {
                        Text("Start workout")
                            .font(.title)
                        Image(systemName: "play.fill")
                            .font(.title)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 10, trailing: 40))
                }
                .navigationTitle(workout.wrappedWorkoutName)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddView.toggle()
                        } label: {
                            Label("Add exercise", systemImage: "plus.circle")
                        }
                    }
                    //                        ToolbarItem(placement: .navigationBarLeading) {
                    //                            NavigationLink(destination: EditWorkoutView(workout: workout)) {
                    //                                Text("Edit)")
                    //                            }
                    //                        }
                }
                .sheet(isPresented: $showingAddView) {
                    AddExerciseView(workout: workout)
                }
            }
            .navigationViewStyle(.stack)
            //            }
        }
    }
    
    private func deleteExercise(offsets:IndexSet) {
//        withAnimation {
//            offsets.map { exercise[$0] }
//                .forEach(viewContext.delete)
            
            // Saves to our database
//            viewContext.saveContext()
//        }
    }
    
    private func totalDuration() -> String {
        var totalTime : Double = 0
        
        
        for item in workout.exerciseArray {
            print(item)
            totalTime += item.duration
        }
        
        let formattedTime = formatFullTimeString(durationMS: totalTime)

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
        
        newWorkout.addToExercises(exercise1)
        
        return WorkoutDetailView(workout: newWorkout).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//        SingleWorkoutView(workout: workout)
    }
}

