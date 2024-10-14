//
//  Exercise.swift
//  GymApp
//
//  Created by Martin Novak on 22.07.2024..
//

import Foundation

struct Exercise: Codable, LoggableExercise {
    
    let exerciseId: Int?
    let name: String?
    let category: String?
    let userExercises: [UserExercise]?
    let trainingPlanExercises: [TrainingPlanExercise]?
}
