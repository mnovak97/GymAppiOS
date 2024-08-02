//
//  BaseApiClient.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import Foundation

protocol BaseApiClient {
    
    var baseUrl: String { get }
    
    func makeRequestUrl(with url: String) -> URL?
    func postRequest<T: Codable>(urlString: String, requestData: T?) async throws -> T
    func getRequest<T: Codable>(urlString: String) async throws -> T
}

extension BaseApiClient {
    
    var baseUrl: String {
        "https://05d8-93-140-211-162.ngrok-free.app/api"
    }
    
    func makeRequestUrl(with url: String) -> URL? {
        guard let url = URL(string: baseUrl)?.appendingPathComponent(url) else {
            return nil
        }
        return url
    }
    
    func postRequest<T>(urlString: String, requestData: T?) async throws -> T where T : Decodable, T : Encodable {
        guard let url = makeRequestUrl(with: urlString ) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
            
        let jsonData = try JSONEncoder().encode(requestData)
        request.httpBody = jsonData
            
        let (data, response) = try await URLSession.shared.data(for: request)
                
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
                    
        switch httpResponse.statusCode {
            case 201:
                let decoder = JSONDecoder()
                let createdData = try decoder.decode(T.self, from: data)
                return createdData
            case 409:
                throw NetworkError.conflict
            default:
                throw NetworkError.invalidResponse
        }
    }
    
    func getRequest<T: Codable>(urlString: String) async throws -> T {
        guard let url = makeRequestUrl(with: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
            case 200:
                let returnedData = try JSONDecoder().decode(T.self, from: data)
                return returnedData
            default:
                throw NetworkError.invalidResponse
        }
    }
}
