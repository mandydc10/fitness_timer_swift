//
//  TimerView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 28/1/2025.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var workout: FetchedResults<Workout>.Element
    
    @StateObject private var vm = ViewModel()
    
    private let timer = Timer.publish(every: 0.001, on: .main, in: .common)
    private let width: Double = 250
    
//    let workoutTitle = workout.wrappedWorkoutName
    let exerciseTitle = "Sit ups"
    let exerciseDuration = 195000
//        Create timer - add .autoconnect() to make it autostart
//    let timer = Timer.publish(every: 0.001, on: .main, in: .common)
    
//        To use date parameter
//        @State var currentDate: Date = Date()
    
    @State var count: Int = 0
    @State var finishedText: String? = nil
    @State var timeRemaining: String = "00:00:00"
    
    func updateTimeRemaining() {
        if count <= 1 {
            finishedText = "Workout complete!"
        } else {
            count += 1
        }
            
//        let remainingExerciseTime = exerciseDuration - count
        let hour = 00
        let minute = 03
        let second = 15
        
        timeRemaining = "\(hour):\(minute):\(second)"
//
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(
                        LinearGradient(gradient:
                                        Gradient(colors: [Color.teal, Color.black.opacity(0.9)]), startPoint:.topLeading, endPoint: .bottomTrailing))
                    .ignoresSafeArea()
                VStack {
                    Text(workout.wrappedWorkoutName)
                        .font(.largeTitle)
                    HStack {
                        VStack{
                            Text("00:00:00")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Remaining")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        VStack{
                            Text("00:00:00")
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
                    Text(exerciseTitle)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Spacer()
                    HStack {
                        Button {
                            //add action function
                        } label: {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 40, weight: .medium, design: .rounded))
                        }
                        Spacer()
//                        Text("00:00:00")
//                            .font(.largeTitle)
                        Text("\(vm.time)")
                            .font(.system(size: 90, weight: .medium, design: .rounded))
                            .padding()
                            .alert("Timer done!", isPresented: $vm.showingAlert) {
                                Button("Continue", role: .cancel) {
                                    // code
                                }
                            }
                        Spacer()
                        Button {
                            //add action function
                        } label: {
                            Image(systemName: "chevron.forward")
                                .font(.system(size: 40, weight: .medium, design: .rounded))
                        }
                    }
                    Spacer()
                    HStack() {
                        Button {
                            vm.reset()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                        }
                        .font(.system(size: 30, weight: .medium, design: .rounded))
                        .tint(.red)
                        Spacer()
                        Button {
                            vm.start(minutes: vm.minutes)
                        } label: {
                            Image(systemName: "play.fill")
                                .font(.system(size: 60, weight: .medium, design: .rounded))
                        }
                        .disabled(vm.isActive)
                        Spacer()
                        Button {
                            vm.reset()
                        } label: {
                            Image(systemName: "pause.fill")
                        }
                        .font(.system(size: 30, weight: .medium, design: .rounded))
                        .tint(.red)
                    }
                    .padding()
                    
                }
                .padding()
            }
        }
        .foregroundColor(Color(hue: 0.118, saturation: 0.978, brightness: 0.966, opacity: 3.0))
        .onReceive(timer) { _ in
            vm.updateCountdown()
//            updateTimeRemaining()
        }
    }

}

//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerView()
//    }
//}
