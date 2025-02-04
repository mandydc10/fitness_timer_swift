//
//  AddQuickTimerView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 2/2/2025.
//

import SwiftUI

struct AddQuickTimerView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var workoutTimer: WorkoutTimer
    
    var body: some View {
        Form {
            Section {
                VStack {
                    Text("Timer: \(String(format: "%02d:%02d", Int(workoutTimer.workoutInitialMins), Int(workoutTimer.workoutInitialSecs)))")
                        .font(.title)
                        .bold()
                        .padding()
                    Text("Seconds")
                    Slider(value: $workoutTimer.workoutInitialSecs, in: 0...59, step: 5)
                    Text("Minutes")
                    Slider(value: $workoutTimer.workoutInitialMins, in: 0...30, step: 1)
                }
                .padding()
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()
                    Button("Set duration") {
                        print("Set time: \(workoutTimer.workoutInitialMins):\(workoutTimer.workoutInitialSecs)")
                        setRemainingTime()
                        setTotalDuration()
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
    }
    
    private func setRemainingTime() {
        workoutTimer.workoutRemainingMinsAsInt = Int(workoutTimer.workoutInitialMins)
        workoutTimer.workoutRemainingSecsAsInt = Int(workoutTimer.workoutInitialSecs)
        }
    
    private func setTotalDuration() {
        workoutTimer.totalDurationMS = calcTimeInMS(durationMins: workoutTimer.workoutInitialMins, durationSecs: workoutTimer.workoutInitialSecs)
        workoutTimer.totalRemainingMS = workoutTimer.totalDurationMS
    }
    
}

struct AddQuickTimerView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuickTimerView().environmentObject(WorkoutTimer())
    }
}
