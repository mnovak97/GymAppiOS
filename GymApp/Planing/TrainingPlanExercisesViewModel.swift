//
//  TrainingPlanExercisesViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 29.08.2024..
//

import Foundation

class TrainingPlanExercisesViewModel: ObservableObject {
    
    @Published var exercises = [Exercise]()
    @Published var selectedExercises = [Exercise]()
    @Published var customExercises = [CustomExercise]()
    @Published var selectedCustomExercises = [CustomExercise]()
    @Published var isLoading: Bool = false
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
    
    func selectExercises(selectedTrainingPlan: TrainingPlan) {
        let user = UserDefaultsUtil.shared.getCurrentUser()
        guard user != nil else { return }

        let selectedExercises = selectedExercises.map { exercise in
            return TrainingPlanExercise(planExerciseId: nil, planId: selectedTrainingPlan.planId ?? 0, exerciseId: exercise.exerciseId, customExerciseId: nil)
        }

        let selectedCustomExercises = selectedCustomExercises.map { customExercise in
            return TrainingPlanExercise(planExerciseId: nil, planId: selectedTrainingPlan.planId ?? 0, exerciseId: nil, customExerciseId: customExercise.customExerciseId)
        }

        let allSelectedExercises = selectedExercises + selectedCustomExercises
        
        guard !allSelectedExercises.isEmpty else {
            print("No exercises selected")
            return
        }
        
        isLoading = true
        Task {
            do {
                try await apiClient.addExercisesToTrainingPlan(trainingPlanId: selectedTrainingPlan.planId ?? 0, selectedExercises: allSelectedExercises)
                isLoading = false
                
            } catch let error as NetworkError {
                DispatchQueue.main.async {
                    print(error.description)
                    self.isLoading = false
                }
            }
        }
    }
    
    
    func isSelectedExercise(exerciseId: Int) -> Bool {
        return selectedExercises.contains(where: { $0.exerciseId == exerciseId })
    }
    
    func toggleSelectionExercise(for exercise: Exercise) {
        if let index = selectedExercises.firstIndex(where: { $0.exerciseId == exercise.exerciseId }) {
            selectedExercises.remove(at: index)
        } else {
            selectedExercises.append(exercise)
        }
    }
    
    func isSelectedCustomExercise(exerciseId: Int) -> Bool {
        return selectedCustomExercises.contains(where: { $0.customExerciseId == exerciseId })
    }
    
    func toggleSelectionCustomExercise(for exercise: CustomExercise) {
        if let index = selectedCustomExercises.firstIndex(where: { $0.customExerciseId == exercise.customExerciseId }) {
            selectedCustomExercises.remove(at: index)
        } else {
            selectedCustomExercises.append(exercise)
        }
    }
}
