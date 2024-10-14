//
//  ExercisesViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 22.07.2024..
//

import Foundation

class ExercisesViewModel: ObservableObject {
    @Published var exercises = [Exercise]()
    @Published var customExercises = [CustomExercise]()
    
    private let apiClient = ApiClient()
    
    init() {
        loadExercises()
    }
    
    func loadExercises() {
        Task {
            do {
                async let fetchedExercises = apiClient.getExercises()
                async let fetchedCustomExercises = apiClient.getCustomExercises()
                
                let exercises = try await fetchedExercises
                let customExercises = try await fetchedCustomExercises
                await MainActor.run {
                    self.exercises = exercises
                    self.customExercises = customExercises
                }
            } catch let error as NetworkError {
                print(error.description)
            } catch {
                print("An unexpected error occurred: \(error.localizedDescription)")
            }
        }
    }
    
    func loadExercises(forID id: Int) {
        Task {
            do {
                async let fetchedTrainingPlan = apiClient.getTrainingPlan(forID: id)
                _ = try await fetchedTrainingPlan
                
                await MainActor.run {
                    
                }
            } catch let error as NetworkError {
                print(error.description)
            } catch {
                print("An unexpected error occurred: \(error.localizedDescription)")
            }
        }
    }
}
