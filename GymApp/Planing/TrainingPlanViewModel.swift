//
//  TrainingPlanViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 15.08.2024..
//

import Foundation

class TrainingPlanViewModel: ObservableObject {
    @Published var trainingPlans: [TrainingPlan] = []
    
    
    private let apiClient = ApiClient()
    
    func loadTrainingPlans() {
        Task {
            do {
                let fetchedTrainingPlans = try await apiClient.getTrainingPlans()
                DispatchQueue.main.async {
                    self.trainingPlans = fetchedTrainingPlans
                }
            } catch let error as NetworkError {
                print(error.description)
            } catch {
                print("An unexpected error occurred: \(error.localizedDescription)")
            }
        }
    }
}
