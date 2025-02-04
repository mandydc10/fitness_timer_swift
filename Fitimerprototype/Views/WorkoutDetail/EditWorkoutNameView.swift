//
//  EditWorkoutView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 29/1/2025.
//

import SwiftUI

struct EditWorkoutNameView: View {
//    @Environment(\.managedObjectContext) private var managedObjContext
    @StateObject var workout: Workout
    @Environment(\.dismiss) var dismiss
    
//    var workout: FetchedResults<Workout>.Element
    
    @State private var workoutName = ""
    @State private var duration: Double = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    Text("Workout name")
                    TextField("\(workout.workout_name ?? "")", text: $workoutName)
                        .onAppear {
                            workoutName = workout.workout_name ?? ""
                            duration = workout.total_duration
                        }
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    
                    HStack {
                        Spacer()
                        Button("Save") {
                            withAnimation {
                                workout.workout_name = workoutName
                                PersistenceController.shared.saveContext()
                            }
//                            DataController.editWorkout(workout: workout, name: name, duration: duration, context: managedObjContext)
                            dismiss()
                        }
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Update Workout")
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    dismiss()
//                } label: {
//                    Text("Cancel")
//                }
//            }
//        }
    }
}

struct EditWorkoutNameView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newWorkout = Workout(context: viewContext)
        newWorkout.workout_name = "Warm up"
        newWorkout.workout_id = UUID()
        
        return EditWorkoutNameView(workout: newWorkout)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
