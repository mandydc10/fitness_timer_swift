//
//  QuickTimer.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 2/2/2025.
//

import SwiftUI

// TODO: Consider setting up a tabview with timer / stopwatch? Will need to investigate removing customtabbar from this view

struct QuickTimerView: View {

    @EnvironmentObject var quickTimer: WorkoutTimer
    
    @State private var showAddView = false
    
    
    var body: some View {

    
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
                        quickTimer.clearTimer()
                    }
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 15)
                            .opacity(0.3)
                        Circle()
                        //                    Set up the progress circle to match the set time (use a durationMS? function)
                            .trim(from:0, to: CGFloat(1 - (quickTimer.totalRemainingMS / quickTimer.totalDurationMS )))
                            .stroke(style: StrokeStyle(lineWidth: 15, lineJoin: .round))
                            .rotationEffect(.degrees(-90))
                        Text("\(String(format: "%02d:%02d", quickTimer.workoutRemainingMinsAsInt, quickTimer.workoutRemainingSecsAsInt))")
                            .font(.system(size: 55, weight: .medium, design: .rounded))
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: 250)
                    
                    HStack {
                        // Reset button sets timer variables back to 'set time'
                        Button {
                            quickTimer.isRunning = false
                            quickTimer.resetTimer()
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
                            if !quickTimer.isRunning {
                                quickTimer.isRunning = true
                                quickTimer.startTimer()
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
                            if quickTimer.isRunning {
                                quickTimer.isRunning = false
                                quickTimer.pauseTimer()
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
                    
                }
                .padding(.horizontal, 30)
                .navigationTitle("Fitimer")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $showAddView) { AddQuickTimerView()
                    .presentationDetents([.fraction(0.7)]) }
            }
        }
        
}

struct QuickTimer_Previews: PreviewProvider {
    static var previews: some View {
        QuickTimerView().environmentObject(WorkoutTimer())
    }
}
