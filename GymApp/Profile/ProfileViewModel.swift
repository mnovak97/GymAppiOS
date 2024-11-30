//
//  ProfileViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 20.07.2024..
//

import Foundation

class ProfileViewModel: ObservableObject {
    private let apiClient = ApiClient()
    @Published var user: User?
    
    init() {
        loadCurrentUser()
    }
    
    func loadCurrentUser() {
        if let currentUser = UserDefaultsUtil.shared.getCurrentUser() {
            user = currentUser
        }
    }
    
    func updateUser(editType: EditType, value: Int) {
        Task {
            guard var userForUpdate = user else { return }
            switch editType {
            case .weight:
                userForUpdate.weight = value
            case .height:
                userForUpdate.height = value
            case .age:
                userForUpdate.age = value
            }
            let updatedUser = try await apiClient.updateUser(user: userForUpdate)
            UserDefaultsUtil.shared.saveUser(currentUser: updatedUser)
            await MainActor.run {
                self.user = updatedUser
            }
        }
    }
    
}
