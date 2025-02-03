//
//  AddQuickTimerView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 2/2/2025.
//

import SwiftUI

struct AddQuickTimerView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var initialSecs: Double
    @Binding var initialMins: Double
    @Binding var remainingSecs: Int
    @Binding var remainingMins: Int
    @Binding var totalDurationMS: Double
    @Binding var totalRemainingMS: Double
//    @State private var durationMins: Double = 0
//    @State private var durationSecs: Double = 0
//    @State private var duration: Double = 0
    
    var body: some View {
        Form {
            Section {
//                Text("Enter timer duration:")
                VStack {
//                    Text("Duration")
//                        .font(.title)
//                        .bold()
//                        .padding()
                    Text("Timer: \(String(format: "%02d:%02d", Int(initialMins), Int(initialSecs)))")
                        .font(.title)
                        .bold()
                        .padding()
                    Text("Seconds")
                    Slider(value: $initialSecs, in: 0...59, step: 5)
                    Text("Minutes")
                    Slider(value: $initialMins, in: 0...30, step: 1)
                }
                .padding()
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()
                    Button("Set duration") {
                        print("Set time: \(initialMins):\(initialSecs)")
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
            remainingMins = Int(initialMins)
            remainingSecs = Int(initialSecs)
        }
    
    private func setTotalDuration() {
        totalDurationMS = calcTimeInMS(durationMins: initialMins, durationSecs: initialSecs)
        totalRemainingMS = totalDurationMS
    }
        
//    private func formattedTime() -> String {
//        let minutes = Int(initialMins)
//        let seconds = Int(initialSecs)
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
    
}

struct AddQuickTimerView_Previews: PreviewProvider {
    static var previews: some View {

        return AddQuickTimerView(initialSecs: .constant(0), initialMins: .constant(0), remainingSecs: .constant(0), remainingMins: .constant(0), totalDurationMS: .constant(0), totalRemainingMS: .constant(0))
    }
}
