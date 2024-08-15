//
//  CreateTrainingPlanViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 15.08.2024..
//

import Foundation

class CreateTrainingPlanViewModel: ObservableObject {
    
    @Published var planName: String = ""
    @Published var description: String = ""
    let apiClient = ApiClient()
    
    func createTrainingPlan(handler: @escaping (Bool) -> Void ) {
        let user = UserDefaultsUtil.shared.getCurrentUser()
        Task {
            do {
                if user != nil {
                    _ = try await apiClient.createTrainingPlan(with: TrainingPlan(planId: nil, userId: user?.userId, planName: planName, description: description, trainingPlanExercises: nil))
                    handler(true)
                }
            } catch let error as NetworkError {
                print(error.description)
                handler(false)
            }
        }
    }
}
