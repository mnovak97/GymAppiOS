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
    var planName: String?
    var description: String?
    var trainingPlanExercises: [TrainingPlanExercise]?
}
