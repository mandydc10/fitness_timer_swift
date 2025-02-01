//
//  TimeFormatting.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 28/1/2025.
//

import Foundation

func calcTimeInMS(durationMins: Double, durationSecs: Double) -> Double {
//    let milliseconds = durationSecs * 1000
    let seconds = durationSecs
    let minutes = durationMins
//    let hours = minutes/60
    let minsAsMS =  minutes * 60000
    let secsAsMS = seconds * 1000
//    let stringHours = String(format: "%02d", hours)

//    let timerString = "\(hours):\(minutes):\(seconds):\(milliseconds)"
    let totalTime = minsAsMS + secsAsMS
    
    return totalTime
}

//func durationInMS(durationMS: Double) -> 
func convertMStoTime(durationMS: Double) -> Array<Int> {
    print(durationMS)
    let hrs = floor(durationMS/3.6e+6)
    let first_remainder = durationMS - (hrs * 3.6e+6)
    let mins = floor(first_remainder / 60000)
    let second_remainder = durationMS - first_remainder - (mins * 60000)
    let secs = floor(second_remainder / 1000)
    let third_remainder = durationMS - second_remainder - (secs * 1000)
    let ms = Int(third_remainder / 1000)
    
    print(Int(hrs), Int(mins), Int(secs), ms)
    
    
    
    return [Int(hrs), Int(mins), Int(secs), ms]
}

func formatMinSecString(durationMS: Double) -> String {
    let formattedTime = convertMStoTime(durationMS: durationMS)
    let shortString = String(format: "%02d:%02d", formattedTime[2], formattedTime[3])
    
    return shortString
}


func formatFullTimeString(durationMS: Double) -> String {
    let formattedTime = convertMStoTime(durationMS: durationMS)
    let longString = String(format: "%02d:%02d:%02d:%02d", formattedTime[0], formattedTime[1], formattedTime[2], formattedTime[3])
    
    print(longString)
    
    return longString
}
