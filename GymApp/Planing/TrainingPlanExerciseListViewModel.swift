//
//  TrainingPlanExerciseListViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 03.10.2024..
//

import Foundation
import SwiftUI

class TrainingPlanExerciseListViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var customExercises: [CustomExercise] = []
    private let apiClient = ApiClient()
    
    func fetchExercises(for trainingPlanId: Int) {
        Task {
            do {
                let trainingPlanExercises = try await apiClient.getTrainingPlanExercises(trainingPlanId: trainingPlanId)

                for exercise in trainingPlanExercises {
                    if let exerciseId = exercise.exerciseId {
                        fetchExerciseForId(exerciseId)
                    } else if let customExerciseId = exercise.customExerciseId {
                        fetchCustomExerciseForId(customExerciseId)
                    }
                }

            } catch let error as NetworkError{
                print(error.description)
            }
        }
    }
    
    func fetchExerciseForId(_ id: Int) {
        Task {
            do {
                let exercise = try await apiClient.getExerciseById(id: id)
                DispatchQueue.main.async {
                    self.exercises.append(exercise)
                }
            } catch let error as NetworkError {
                print(error.description)
            }
        }
    }
    
    func fetchCustomExerciseForId(_ id: Int) {
        Task {
            do {
                let customExercise = try await apiClient.getCustomExerciseById(id: id)
                DispatchQueue.main.async {
                    self.customExercises.append(customExercise)
                }
            } catch let error as NetworkError {
                print(error.description)
            }
        }
    }
}
