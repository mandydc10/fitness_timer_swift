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
    
    @EnvironmentObject var workoutTimer: WorkoutTimer
    
    @StateObject var workout: Workout
    //    var workout: FetchedResults<Workout>.Element
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var exercise: FetchedResults<Exercise>
    
//    @State var currentExercise: Exercise = workout.exerciseArray[0]
    
    @State private var showAddView = false
    @State private var showTimerView = false
    
//    var currentExercise: Exercise = Exercise()
    
//    init() {
//        print("Initialising")
//        setTimerToWorkout()
//        print("TimerWorkoutSet with \(workoutTimer.totalDurationMS)")
//    }
    
    var body: some View {
            NavigationStack {
                VStack(alignment: .leading) {
                    Text("\(totalDurationToString(totalWorkoutDurationMS: totalDurationMS())) total duration")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    Button {
                        print("workout play button pressed")
                        setTimerToWorkout()
                        showTimerView.toggle()
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 80, weight: .medium, design: .rounded))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
//                    NavigationLink(destination: TimerView(workout: workout)) {
//                        Image(systemName: "play.circle.fill")
//                            .font(.system(size: 80, weight: .medium, design: .rounded))
//                    }
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    
                    
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
                .sheet(isPresented: $showTimerView) {
                    TimerView()
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
    
    private func totalDurationMS() -> Double {
        var totalTimeMS : Double = 0
        
        
        for item in workout.exerciseArray {
            print(item)
            totalTimeMS += item.duration
        }

        print("Total workout time in MS: \(totalTimeMS)")
        return totalTimeMS
    }
    
    private func totalDurationToString(totalWorkoutDurationMS: Double) -> String {
        
        let formattedTime = formatMinSecHrString(durationMS: totalWorkoutDurationMS)

        print("Total workout time formatted: \(formattedTime)")
        return formattedTime
    }
    
    private func setTimerToWorkout() {
        
        print("set timer to workout function started")
        let fullDuration = totalDurationMS()
        workoutTimer.totalDurationMS = fullDuration
        workoutTimer.totalRemainingMS = fullDuration
        print("first run complete")
        let timeComponents = convertMStoTime(durationMS: fullDuration)
        workoutTimer.workoutRemainingSecsAsInt = timeComponents[2]
        workoutTimer.workoutRemainingMinsAsInt = timeComponents[1]
        workoutTimer.workoutInitialSecs = Double(timeComponents[2])
        workoutTimer.workoutInitialMins = Double(timeComponents[1])
        workoutTimer.exerciseArray = workout.exerciseArray
        workoutTimer.currentExerciseIndex = 0
        print("second run complete")

//        workoutTimer.currentExerciseDurationMS = 0
        
        
        print("workout timer duration now = \(workoutTimer.totalDurationMS)")
        
        
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
        
        return WorkoutDetailView(workout: newWorkout)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(WorkoutTimer())
    }
}

