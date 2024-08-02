//
//  NetworkError.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    
    case invalidURL
    case invalidResponse
    case invalidData
    case conflict
    case unauthorized
    case other(Error)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        case .conflict:
            return "Username or email already exists"
        case .unauthorized:
            return "Wrong username or password"
        case .invalidData:
            return "Invalid Data"
        case .other(let error):
            return "Other Error: \(error.localizedDescription)"
        }
    }
}
