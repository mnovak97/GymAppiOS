//
//  LoggableExercise.swift
//  GymApp
//
//  Created by Martin Novak on 30.08.2024..
//

import Foundation

protocol LoggableExercise {
    var name: String? { get }
    var category: String? { get }
    var systemName: String { get }
}

extension LoggableExercise {
    var systemName: String {
        var imageString = ""
        if category == "Strength" {
            imageString = "figure.strengthtraining.traditional"
        } else if category == "Core" {
            imageString = "figure.core.training"
        } else if category == "Functional" {
            imageString = "figure.strengthtraining.functional"
        } else {
            imageString = "figure.cross.training"
        }
        return imageString
    }
}
