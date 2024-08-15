//
//  TrainingPlan.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import Foundation

struct TrainingPlan: Codable {
    let planId: Int?
    let userId: Int?
    let planName: String?
    let description: String?
    let trainingPlanExercises: [TrainingPlanExercise]?
}
