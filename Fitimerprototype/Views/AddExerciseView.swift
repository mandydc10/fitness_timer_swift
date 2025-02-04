//
//  AddExerciseView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 28/1/2025.
//

import SwiftUI
import CoreData

struct AddExerciseView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var workout: FetchedResults<Workout>.Element?
    
    @State private var name = ""
    @State private var durationMins: Double = 0
    @State private var durationSecs: Double = 0
    @State private var duration: Double = 0
    
    
    var body: some View {
        // TODO: Fix 'add exercise' for non workout option i.e. exercise library addition
        NavigationView {
            Form {
                Section() {
                    Text("\(workout?.wrappedWorkoutName ?? "Exercise Library")")
                    TextField("Exercise name", text: $name)
                    
                    VStack {
//                        Text("Duration")
//                            .font(.title)
//                            .bold()
//                            .padding()
//                        Text("Seconds: \(Int(durationSecs))")
//                        Slider(value: $durationSecs, in: 0...59, step: 5)
//                        Text("Minutes: \(Int(durationMins))")
//                        Slider(value: $durationMins, in: 0...59, step: 1)
                        Text("Timer: \(String(format: "%02d:%02d", Int(durationMins), Int(durationSecs)))")
                            .font(.title)
                            .bold()
                            .padding()
                        Text("Seconds")
                        Slider(value: $durationSecs, in: 0...59, step: 5)
                        Text("Minutes")
                        Slider(value: $durationMins, in: 0...30, step: 1)
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        Button("Add exercise") {
                            duration = calculateDuration(durationMins: durationMins, durationSecs: durationSecs)
                            print(duration)
                            DataController().addExercise(
                                name: name,
                                duration: duration,
                                workout: ((workout ?? workout?.wrappedExerciseLibrary)!),
                                context: managedObjectContext)
                            
                            if workout != nil {
                                DataController().editWorkout(
                                    workout: workout!,
                                    name: workout!.wrappedWorkoutName,
                                    duration: workout!.total_duration + duration,
                                context: managedObjectContext)
                            }
                            dismiss()
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Add Exercise")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
    
    private func calculateDuration(durationMins: Double, durationSecs: Double) -> Double {
        duration = calcTimeInMS(durationMins: durationMins, durationSecs: durationSecs)
        return duration
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newWorkout = Workout(context: viewContext)
        newWorkout.workout_name = "Upper Body"
        newWorkout.workout_id = UUID()

        return AddExerciseView(workout: newWorkout)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

//struct AddExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        let context = PreviewContextProvider.shared.viewContext  // Get a preview Core Data context
//                let workout = Workout(context: context)  // Create a mock Workout instance
//                workout.workout_name = "Sample Workout"  // Assign some test data
//                
//                return AddExerciseView(workout: workout)
//    }
//}
