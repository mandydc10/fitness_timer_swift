//
//  TimerView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 28/1/2025.
//

import SwiftUI

struct TimerView: View {
    // TODO: Get this working with new WorkoutTimer class
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var workoutTimer: WorkoutTimer
    
    var workout: FetchedResults<Workout>.Element?
    
//    @Binding var currentExerciseIndex: Int? = workoutTimer.currentExerciseIndex
    
//    @State private var exerciseArray: [Exercise] = (workout?.exerciseArray ?? <#default value#>)
    
//    @StateObject private var vm = ViewModel()
//    @State var finishedText: String? = nil

    
    var body: some View {
    
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(
                        LinearGradient(gradient:
                                        Gradient(colors: [Color.teal, Color.black.opacity(0.9)]), startPoint:.topLeading, endPoint: .bottomTrailing))
                    .ignoresSafeArea()
                VStack {
//                    Text((workout?.wrappedWorkoutName ?? vm.workoutName)!)
//                        .font(.largeTitle)
//                        .bold()
                    HStack {
                        VStack{
                            Text("\(formatMinSecHrString(durationMS: workoutTimer.totalRemainingMS))")
//                            Text("00:00:00")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Remaining")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        VStack{
                             Text("\(formatMinSecHrString(durationMS: (workoutTimer.totalDurationMS - workoutTimer.totalRemainingMS)))")
//                            Text("00:00:00")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            Text("Elapsed")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 1, leading: 20, bottom: 10, trailing: 20))
                    
                    Spacer()
                    
                    Text("EXERCISE VIDEO GOES HERE")
                        .foregroundColor(.white)
                        .italic()
                    
                    Spacer()
                    
                    Text("No exercise set")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            // TODO: add "skip to previous exercise" action function
                        } label: {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 40, weight: .medium, design: .rounded))
                        }
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 15)
                                .opacity(0.3)
                            Circle()
//                    Set up the progress circle to match the set time (use a durationMS? function)
                                .trim(from:0, to: CGFloat(1 - (workoutTimer.totalRemainingMS / workoutTimer.totalDurationMS )))
                                .stroke(style: StrokeStyle(lineWidth: 15, lineJoin: .round))
                                .rotationEffect(.degrees(-90))
                            Text("\(String(format: "%02d:%02d", workoutTimer.workoutRemainingMinsAsInt, workoutTimer.workoutRemainingSecsAsInt))")
                                .font(.system(size: 55, weight: .medium, design: .rounded))
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: 250)
//                        Text("\(formatMinSecString(durationMS: (workout?.exerciseArray[0].duration)!))")
//                            .font(.system(size: 90, weight: .medium, design: .rounded))
//                            .padding()
//                            .alert("Timer done!", isPresented: $vm.showingAlert) {
//                                Button("Continue", role: .cancel) {
//                                    // code
//                                }
//                            }
                        
                        Spacer()
                        
                        Button {
                            // TODO: add "skip to next exercise" action function
                        } label: {
                            Image(systemName: "chevron.forward")
                                .font(.system(size: 40, weight: .medium, design: .rounded))
                        }
                    }
                    Spacer()
                    
                    HStack() {
                        // Reset timer back to initial exercise duration
                        Button {
                            workoutTimer.isRunning = false
                            workoutTimer.resetTimer()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                        }
                        .font(.system(size: 30, weight: .medium, design: .rounded))
                        
                        Spacer()
                        
                        // Start timer button
                        Button {
                            //                            vm.start(minutes: vm.minutes)
                            if !workoutTimer.isRunning {
                                workoutTimer.isRunning = true
                                workoutTimer.startTimer()
                            }
                        } label: {
                            Image(systemName: "play.fill")
                                .font(.system(size: 60, weight: .medium, design: .rounded))
                        }
                        Spacer()
                        
                        // Pause timer button
                        Button {
                            if workoutTimer.isRunning {
                                workoutTimer.isRunning = false
                                workoutTimer.pauseTimer()
                            }
                            
                        } label: {
                            Image(systemName: "pause.fill")
                        }
                        .font(.system(size: 30, weight: .medium, design: .rounded))
                    }
                    .padding()
                    
                }
                .padding()
            }
        }
        .foregroundColor(Color(hue: 0.118, saturation: 0.978, brightness: 0.966, opacity: 3.0))
        .navigationTitle((workout?.wrappedWorkoutName ?? "unknown workout")!)
    }

}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newWorkout = Workout(context: viewContext)
        newWorkout.workout_name = "Upper Body"
        newWorkout.workout_id = UUID()
        newWorkout.total_duration = 60000
        
        let newExercise1 = Exercise(context: viewContext)
        newExercise1.name = "Pull ups"
        newExercise1.id = UUID()
        newExercise1.duration = 60000
        
        newWorkout.addToExercises(newExercise1)
        
//        let currentExerciseIndex = 0

        return TimerView(workout: newWorkout)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(WorkoutTimer())
    }
}

//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerView()
//    }
//}
