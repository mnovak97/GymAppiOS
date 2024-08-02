//
//  UserExercise.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import Foundation

struct UserExercise: Codable {
    
    let userExerciseId: Int
    let userId: Int
    let exerciseId: Int
    let weight: Int
    let repetitions: Int
}
