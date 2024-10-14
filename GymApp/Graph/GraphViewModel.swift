//
//  GraphViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 03.10.2024..
//

import Foundation

struct ExerciseGraphData {
    let date: Date
    let weight: Float
    let repetitions: Int
}

class GraphViewModel: ObservableObject {
    @Published var userExercises: [UserExercise] = []
    @Published var exerciseNames: [Int: String] = [:]
    @Published var isLoading: Bool = false
    private let apiClient = ApiClient()

    
    init() {
        fetchUserExercises()
    }
    
    func fetchUserExercises() {
        Task {
            do {
                let user = UserDefaultsUtil.shared.getCurrentUser()
                let exercises = try await apiClient.getUserExercises(id: user?.userId ?? 0)
                DispatchQueue.main.async {
                    self.userExercises = exercises
                    if !exercises.isEmpty {
                        self.fetchExerciseNames(for: exercises)
                    }
                    self.isLoading = false
                }
            } catch let error as NetworkError {
                print(error.description)
            }
        }
    }

    func fetchExerciseNames(for exercises: [UserExercise]) {
        let groupedExercises = groupExercisesById(exercises: exercises)
        for (exerciseId, _) in groupedExercises {
            fetchExerciseName(exerciseId: exerciseId)
        }
    }

    func fetchExerciseName(exerciseId: Int) {
        Task {
            do {
                let exerciseName = try await apiClient.getExerciseName(id: exerciseId)
                DispatchQueue.main.async {
                    self.exerciseNames[exerciseId] = exerciseName
                }
            } catch let error as NetworkError {
                print("Error fetching exercise name: \(error.description)")
            }
        }
    }

    func groupExercisesById(exercises: [UserExercise]) -> [Int: [UserExercise]] {
        var groupedExercises = [Int: [UserExercise]]()

        for exercise in exercises {
            let key = exercise.exerciseId ?? exercise.customExerciseId ?? 0
            if groupedExercises[key] != nil {
                groupedExercises[key]?.append(exercise)
            } else {
                groupedExercises[key] = [exercise]
            }
        }

        return groupedExercises
    }
    
    func prepareGraphData(for exercises: [UserExercise]) -> [ExerciseGraphData] {
        let isoFormatter = ISO8601DateFormatter()

        return exercises.compactMap { exercise in
            if let date = isoFormatter.date(from: exercise.date) {
                return ExerciseGraphData(date: date, weight: Float(exercise.weight), repetitions: exercise.repetitions)
            } else {
                print("Invalid date format: \(exercise.date)")
                return nil
            }
        }
    }
}
