//
//  ApiClient.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import Foundation

class ApiClient: BaseApiClient {
    
    func createUser(with user: User) async throws -> User {
        let user = try await postRequest(urlString: "User", requestData: user)
        
        return user
    }
    
    func getExercises() async throws -> [Exercise] {
        var exercises: [Exercise] = []
        guard let url = makeRequestUrl(with: "Exercise") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
             exercises = try JSONDecoder().decode([Exercise].self, from: data)
        } catch {
            print(String(describing: error))
            throw NetworkError.invalidData
        }
        return exercises
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
