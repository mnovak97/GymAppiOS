//
//  User.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import Foundation

struct User: Codable {
    
    let userId: Int?
    let username: String?
    let passwordHash: String?
    let email: String?
    let firstName: String?
    let lastName: String?
    var age: Int?
    let gender: Gender
    var weight: Int?
    var height: Int?
    let userExercises: [UserExercise]?
    let customExercises: [CustomExercise]?
    let trainingPlans: [TrainingPlan]?
}
