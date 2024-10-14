//
//  LogExerciseViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 03.10.2024..
//

import Foundation

class LogExerciseViewModel: ObservableObject {
    private let apiClient = ApiClient()
    
    @Published var weightString: String = ""
    @Published var weightInt: Int? = nil
    @Published var repsString: String = ""
    @Published var repsInt: Int? = nil
    @Published var isLoading: Bool = false
    var onDismiss: (() -> Void)?
    
    func logUserExercise(exerciseId: Int?, customExerciseId: Int?) {
        guard let weight = weightInt, let reps = repsInt else {
            print("Invalid weight or repetitions.")
            return
        }
        
        guard (exerciseId != nil || customExerciseId != nil) else {
            print("Either exerciseId or customExerciseId must be provided.")
            return
        }

        let user = UserDefaultsUtil.shared.getCurrentUser()
        let dateFormatter = ISO8601DateFormatter()
        let isoDateString = dateFormatter.string(from: Date())
        let userExercise = UserExercise(
            userExerciseId: nil,
            userId: user?.userId ?? 0,
            exerciseId: exerciseId,
            customExerciseId: customExerciseId,
            weight: weight,
            repetitions: reps,
            date: isoDateString
        )

        logExercise(userExercise: userExercise)
    }
    
    func logExercise(userExercise: UserExercise) {
        isLoading = true
        Task {
            do {
                _ = try await apiClient.logExercise(userExercise: userExercise)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.onDismiss?()
                }
            } catch let error as NetworkError {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                print(error.description)
            }
        }
    }
    
    func filterWeight(_ value: String) {
        if let intValue = Int(value) {
            self.weightInt = intValue
        } else {
            self.weightInt = nil
        }
        self.weightString = value.filter { "0123456789".contains($0) }
    }

    func filterReps(_ value: String) {
        if let intValue = Int(value) {
            self.repsInt = intValue
        } else {
            self.repsInt = nil
        }
        self.repsString = value.filter { "0123456789".contains($0) }
    }
}
