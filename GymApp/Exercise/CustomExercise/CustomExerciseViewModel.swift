//
//  CustomExerciseViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 02.08.2024..
//
import Foundation

class CustomExerciseViewModel: ObservableObject {
    @Published var customExercises = [CustomExercise]()
    @Published var name: String = ""
    @Published var category: String = ""
    
    private let apiClient = ApiClient()
    
    func createCustomExercise() {
        let user = UserDefaultsUtil.shared.getCurrentUser()
        Task {
            do {
                if user != nil {
                    _ = try await apiClient.createCustomExercise(with: CustomExercise(customExerciseId: nil, userId: user?.userId, name: name, category: category, userExercises: nil, trainingPlanExercises: nil))
                }
            } catch let error as NetworkError {
                print(error.description)
            }
        }
    }
   
}
