//
//  QuickTimer.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 2/2/2025.
//

import SwiftUI

struct QuickTimerView: View {
    
//    @State var stringSecs: String = "00"
//    @State var stringMins: String = "00"
    @State var initialSecs: Double = 00
    @State var initialMins: Double = 00
    @State var remainingSecs: Int = 00
    @State var remainingMins: Int = 00
    @State var totalDurationMS: Double = 0
    @State var totalRemainingMS: Double = 0
    
    @State private var timeRemaining: TimeInterval = 0
    @State private var timer: Timer?
    @State private var isRunning: Bool = false
    
    @State private var showAddView = false
    
    
    var body: some View {
        
        // TODO: Consider setting up a tabview with timer / stopwatch? Will need to investigate removing customtabbar from this view
        
        NavigationStack {
            VStack(alignment: .center) {
                
                Spacer()
                
                // Button to pull up view for setting the timer duration
                Button("Set time") {
                    showAddView = true
                }
                .buttonStyle(.borderedProminent)
                
                // Clears timer and all variables of any 'set times', i.e. returns back to 00:00
                Button("Clear timer") {
                    initialSecs = 0
                    initialMins = 0
                    remainingSecs = 0
                    remainingMins = 0
                    totalDurationMS = 0
                    totalRemainingMS = 0
                }
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 15)
                        .opacity(0.3)
                    Circle()
//                    Set up the progress circle to match the set time (use a durationMS? function)
                        .trim(from:0, to: CGFloat(1 - (totalRemainingMS / totalDurationMS )))
                        .stroke(style: StrokeStyle(lineWidth: 15, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                    Text("\(String(format: "%02d:%02d", remainingMins, remainingSecs))")
                        .font(.system(size: 55, weight: .medium, design: .rounded))
                        .fontWeight(.bold)
                }
                .frame(maxWidth: 250)
                
                HStack {
                    
                    // Reset button sets timer variables back to 'set time'
                    Button {
                        isRunning = false
                        resetTimer()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundStyle(.foreground)
                            .frame(width: 50, height: 50)
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    Spacer()
                    
                    // Play timer button
                    Button {
                        if !isRunning {
                            isRunning = true
                            startTimer()
                        }
                    } label: {
//                        Image(systemName: isRunning ? "stop.fill" : "play.fill")
                        Image(systemName: "play.fill")
                            .foregroundStyle(.foreground)
                            .frame(width: 50, height: 50)
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    Spacer()
                    
                    // Pause timer button
                    Button {
                        if isRunning {
                            isRunning = false
                            pauseTimer()
                        }
                    } label: {
                        Image(systemName: "pause.fill")
                            .foregroundStyle(.foreground)
                            .frame(width: 50, height: 50)
                            .font(.largeTitle)
                            .padding()
                    }
                }
                
                Spacer()
                
                Spacer()
        
            }
            .padding(.horizontal, 30)
            .navigationTitle("Fitimer")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAddView) { AddQuickTimerView(initialSecs: $initialSecs, initialMins: $initialMins, remainingSecs: $remainingSecs, remainingMins: $remainingMins, totalDurationMS: $totalDurationMS, totalRemainingMS: $totalRemainingMS)
                .presentationDetents([.fraction(0.7)]) }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    NavigationLink(destination: HomeView()){
//                        Image(systemName: "chevron.left")
//                        Text("Back")
//                    }
//                }
//            }
            
        }
            
    }
    
//    private func formattedSetTime() -> String {
//        let minutes = Int(timeRemaining)
//        let seconds = Int(timeRemaining)
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
    
        private func startTimer() {
            print("Timer started")
            print("total duration MS: \(totalDurationMS) ms")
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                print("total duration: \(totalDurationMS)")
                print("Timer started")
                if remainingSecs > 0 {
                    remainingSecs -= 1
                    totalRemainingMS -= 1000
                    print("total remaining MS: \(totalRemainingMS) ms")
                } else {
                    if remainingMins > 0 {
                        remainingMins -= 1
                        remainingSecs = 59
                        totalRemainingMS -= 1000
                        print("total remaining MS: \(totalRemainingMS) ms")
                    } else {
                        resetTimer()
                    }
                }
            }
        }
        
        private func pauseTimer() {
            print("Timer paused")
            isRunning = false
            timer?.invalidate()
        }
        
        private func resetTimer() {
            print("Timer reset")
            isRunning = false
            timer?.invalidate()
            remainingMins = Int(initialMins)
            remainingSecs = Int(initialSecs)
            totalRemainingMS = totalDurationMS
//            timeRemaining = 10
        }
        
}

struct QuickTimer_Previews: PreviewProvider {
    static var previews: some View {
        QuickTimerView()
    }
}
