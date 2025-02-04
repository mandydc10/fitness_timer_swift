//
//  EditExerciseView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 29/1/2025.
//

import SwiftUI

struct EditExerciseView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @StateObject var exercise: Exercise
//    var exercise: FetchedResults<Exercise>.Element

    @State private var name = ""
    @State private var durationMins: Double = 0
    @State private var durationSecs: Double = 0
    @State private var duration: Double = 0
    
    var body: some View {
        // TODO: Consider bringing exercise current duration into slider values as initial values
        
        NavigationView {
            Form {
                Section() {
                    Text("\(exercise.wrappedExerciseWorkoutName)")
                    TextField("\(exercise.name ?? "")", text: $name)
                        .onAppear {
                            name = exercise.name!
                            duration = exercise.duration
                        }
                        .textFieldStyle(.roundedBorder)
                    VStack {
                        Text("Duration")
                            .font(.title)
                            .bold()
                            .padding()
                        Text("Seconds: \(Int(durationSecs))")
                        Slider(value: $durationSecs, in: 0...59, step: 5)
                        Text("Minutes: \(Int(durationMins))")
                        Slider(value: $durationMins, in: 0...59, step: 1)
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        Button("Save") {
                            DataController().editExercise(
                                exercise: exercise,
                                name: name,
                                duration: duration,
                                context: managedObjContext)
                            dismiss()
                        }
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Update Exercise")
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

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newExercise = Exercise(context: viewContext)
        newExercise.name = "Squats"
        newExercise.id = UUID()
        
        return EditExerciseView(exercise: newExercise)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
