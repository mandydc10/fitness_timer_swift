//
//  Timer.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 4/2/2025.
//

import Foundation
import SwiftUI

//    For timers - add .autoconnect() to make it autostart
//    To create a timer: let timer = Timer.publish(every: 0.001, on: .main, in: .common)

class WorkoutTimer: ObservableObject {
    
    @Published var workoutInitialSecs: Double = 00
    @Published var workoutInitialMins: Double = 00
    @Published var workoutRemainingSecsAsInt: Int = 00
    @Published var workoutRemainingMinsAsInt: Int = 00
    @Published var totalDurationMS: Double = 0
    @Published var totalRemainingMS: Double = 0
    
    @Published var isRunning: Bool = false
    
    private var timer: Timer?
    
    @Published var exerciseArray: [Exercise] = []
    @Published var currentExerciseIndex = 0
//    @Published var currentExerciseDurationMS = 0
//    @Published var currentExercise: Exercise = Exercise()
    
    func startTimer() {
        print("Timer started")
        print("total duration MS: \(self.totalDurationMS) ms")
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            print("total duration: \(self.totalDurationMS)")
            print("Timer started")
            if self.workoutRemainingSecsAsInt > 0 {
                self.workoutRemainingSecsAsInt -= 1
                self.totalRemainingMS -= 1000
                print("total remaining MS: \(self.totalRemainingMS) ms")
            } else {
                if self.workoutRemainingMinsAsInt > 0 {
                    self.workoutRemainingMinsAsInt -= 1
                    self.workoutRemainingSecsAsInt = 59
                    self.totalRemainingMS -= 1000
                    print("total remaining MS: \(self.totalRemainingMS) ms")
                } else {
                    self.resetTimer()
                }
            }
        }
    }
    
    func pauseTimer() {
        print("Timer paused")
        self.isRunning = false
        self.timer?.invalidate()
    }
    
    func resetTimer() {
        print("Timer reset")
        self.isRunning = false
        self.timer?.invalidate()
        self.workoutRemainingMinsAsInt = Int(self.workoutInitialMins)
        self.workoutRemainingSecsAsInt = Int(self.workoutInitialSecs)
        self.totalRemainingMS = self.totalDurationMS
    }
    
    func clearTimer() {
        self.workoutInitialSecs = 0
        self.workoutInitialMins = 0
        self.workoutRemainingSecsAsInt = 0
        self.workoutRemainingMinsAsInt = 0
        self.totalDurationMS = 0
        self.totalRemainingMS = 0
    }
    
    func endWorkoutAlert() {
//        Alert(title: "Workout completed" message: "Workout complete!")
    }
    
}
