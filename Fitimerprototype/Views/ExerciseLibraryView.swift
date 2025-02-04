//
//  File.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 27/1/2025.
//

import SwiftUI

struct ExerciseLibraryView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var exercise: FetchedResults<Exercise>
    
//    @State private var showingAddAlert = false
    @State private var exerciseName: String = ""
    
    @State private var showAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(exercise) { exercise in
                        NavigationLink(destination: EditExerciseView(exercise: exercise)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 16) {
                                    Text(exercise.wrappedName)
                                        .bold()
                                    Text("Duration: \(formatMinSecHrString(durationMS: exercise.duration))").foregroundColor(.gray)
//                                        .padding()
                                }
                            }
                        }
                    }
                                    .onDelete(perform: deleteExercise)
                    .listStyle(.plain)
//                    Spacer()
                }
                .navigationTitle("My Exercises")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Label("Add exercise", systemImage: "plus.circle")
                    }
//                    .alert("New Exercise", isPresented: $showingAddAlert) {
//                        TextField("Enter exercise name", text: $exerciseName)
//                        Button("Add Exercise", action: addExercise)
//                        Button("Cancel", role: .cancel) { }
//                    }
//                    message: {
//                            Text("Add workout name")
//                        }
                    .accessibilityLabel("Add new exercise")
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddView) { AddExerciseView()
//                    .presentationDetents([.fraction(0.7)])
            }
        }
    }
    
    func addExercise() {
        // TODO add function to add exercise without workout assigned
    }
    
    func deleteExercise(offsets:IndexSet) {
        // add function to delete exercise
        withAnimation {
            offsets.map { exercise[$0] }
                .forEach(viewContext.delete)
            
            // Save to database
            PersistenceController.shared.saveContext()
        }
    }
}


struct ExerciseLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseLibraryView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

//struct Previews_ExerciseRow_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
