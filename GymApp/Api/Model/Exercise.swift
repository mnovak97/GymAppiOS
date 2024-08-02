//
//  Exercise.swift
//  GymApp
//
//  Created by Martin Novak on 22.07.2024..
//

import Foundation

struct Exercise: Codable {
    let exerciseId: Int?
    let name: String?
    let category: String?
    let userExercises: [UserExercise]?
    let trainingPlanExercises: [TrainingPlanExercise]?
    
    var systemName: String {
        var imageString = ""
        if category == "Strength" {
            imageString = "figure.strengthtraining.traditional"
        } else if category == "Core" {
            imageString = "figure.core.training"
        } else if category == "Functional" {
            imageString = "figure.strengthtraining.functional"
        }
        return imageString
    }
    
}
