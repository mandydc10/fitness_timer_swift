//
//  WorkoutTimerViewModel.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 4/2/2025.
//

import Foundation

class WorkoutTimerViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded(Workout)
    }
}

//@Published private(set) var state = State.idle
//
//private let workout
