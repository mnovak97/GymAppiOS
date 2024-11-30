//
//  ApiClient.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import Foundation

class ApiClient: BaseApiClient {
    
    func createTrainingPlan(with trainingPlan: TrainingPlan) async throws -> TrainingPlan {
        let trainingPlan = try await postRequest(urlString: "TrainingPlan", requestData: trainingPlan)
        return trainingPlan
    }
    
    func createUser(with user: User) async throws -> User {
        let user = try await postRequest(urlString: "User", requestData: user)
        return user
    }
    
    func createCustomExercise(with customExercise: CustomExercise) async throws -> CustomExercise {
        let customExercise = try await postRequest(urlString: "CustomExercise", requestData: customExercise)
        return customExercise
    }
    
    func getExerciseName(id: Int) async throws -> String {
        let url = URL(string: "\(baseUrl)/Exercise/\(id)/name")!

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
            print("Server returned error: \(errorMessage)")
            throw NetworkError.invalidResponse
        }

        guard let exerciseName = String(data: data, encoding: .utf8) else {
            print("Failed to convert data to string.")
            throw NetworkError.invalidData
        }
            
        return exerciseName
    }
    
    func updateUser(user: User) async throws -> User {
        let updatedUser = try await putRequest(urlString: "User/\(String(user.userId ?? 0))", requestData: user)
        return updatedUser
    }
    
    func getExercises() async throws -> [Exercise] {
        return try await getRequest(urlString: "Exercise")
    }
    
    func getUserExercises(id: Int) async throws -> [UserExercise] {
        return try await getRequest(urlString: "UserExercise" + "/\(String(id))/user")
    }
    
    func getExerciseById(id: Int) async throws -> Exercise {
        return try await getRequest(urlString: "Exercise" + "/\(String(id))")
    }
    
    func getCustomExerciseById(id: Int) async throws -> CustomExercise {
        return try await getRequest(urlString: "CustomExercise" + "/\(String(id))")
    }
    
    func getTrainingPlanExercises(trainingPlanId: Int) async throws -> [TrainingPlanExercise] {
        return try await getRequest(urlString: "TrainingPlan" + "/\(String(trainingPlanId))/exercises")
    }
    
    func logExercise(userExercise: UserExercise) async throws -> UserExercise {
        let userExercise = try await postRequest(urlString: "UserExercise/log", requestData: userExercise)
        return userExercise
    }
    
    func addExercisesToTrainingPlan(trainingPlanId: Int, selectedExercises: [TrainingPlanExercise]) async throws {
        try await postRequest(
            urlString: "TrainingPlan/addExercises" + "/\(String(trainingPlanId))",
            requestData: selectedExercises
        )
    }
    
    func getTrainingPlan(forID id: Int) async throws -> TrainingPlan {
        return try await getRequest(urlString: "TrainingPlan" + "/\(String(id))")
    }
    
    func getCustomExercises() async throws -> [CustomExercise] {
        return try await getRequest(urlString: "CustomExercise")
    }
    
    func getTrainingPlans() async throws -> [TrainingPlan] {
        return try await getRequest(urlString: "TrainingPlan")
    }
    
    func loginUser(username: String, password: String) async throws -> User {
        let loginDto = LoginDto(username: username, password: password)
        
        guard let url = makeRequestUrl(with: "User/login" ) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            
        let jsonData = try JSONEncoder().encode(loginDto)
        request.httpBody = jsonData
            
        let (data, response) = try await URLSession.shared.data(for: request)
                
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
                    
        switch httpResponse.statusCode {
            case 200:
                let decoder = JSONDecoder()
                let createdData = try decoder.decode(User.self, from: data)
                return createdData
            case 401:
                throw NetworkError.unauthorized
            default:
                throw NetworkError.invalidResponse
        }
    }
}
