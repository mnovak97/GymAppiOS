//
//  CustomExercise.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import Foundation

struct CustomExercise: Codable, LoggableExercise {
    
    let customExerciseId: Int?
    let userId: Int?
    let name: String?
    let category: String?
    let userExercises: [UserExercise]?
    let trainingPlanExercises: [TrainingPlanExercise]?
}
