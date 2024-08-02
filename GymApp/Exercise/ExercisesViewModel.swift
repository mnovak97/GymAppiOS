//
//  ExercisesViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 22.07.2024..
//

import Foundation

class ExercisesViewModel: ObservableObject {
    @Published var exercises = [Exercise]()
    
    private let apiClient = ApiClient()
    
    init() {
        loadExercises()
    }
    
    func loadExercises() {
        Task {
            do {
                let fetchedExercises = try await apiClient.getExercises()
                DispatchQueue.main.async {
                    self.exercises = fetchedExercises
                }
            } catch let error as NetworkError {
                print(error.description)
            } catch {
                print("An unexpected error occurred: \(error.localizedDescription)")
            }
        }
    }
}
