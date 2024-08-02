//
//  TrainingPlanExercise.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import Foundation

struct TrainingPlanExercise: Codable {
    let planExerciseId: Int
    let planId: Int
    let exerciseId: Int
    let customExerciseId: Int
    let sets: Int
    let repetitions: Int
}
