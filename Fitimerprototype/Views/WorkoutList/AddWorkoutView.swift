//
//  AddWorkoutView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 2/2/2025.
//

import SwiftUI
import CoreData

struct AddWorkoutView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.workout_name)]) var workout: FetchedResults<Workout>

    @State private var workoutName: String = ""
    @State private var showingAddAlert = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            TextField("Enter workout name", text: $workoutName)
                .textFieldStyle(.roundedBorder)
            HStack {
                Button("Cancel") { dismiss() }
                Spacer()
                Button("Add Workout", action: addWorkout)
                    .buttonStyle(.borderedProminent)
                    .disabled(workoutName.trimmingCharacters(in:
                            .whitespacesAndNewlines).isEmpty)
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(6)
        }
        .padding()
        
    }
    
    private func addWorkout() {
        let cleanedName = workoutName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        withAnimation {
            let newWorkout = Workout(context: viewContext)
            newWorkout.workout_name = cleanedName
            newWorkout.workout_id = UUID()

            // Save to database
            PersistenceController.shared.saveContext()
            dismiss()
            }
        }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
