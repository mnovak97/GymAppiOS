//
//  ProfileViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 20.07.2024..
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    
    init() {
        loadCurrentUser()
    }
    
    func loadCurrentUser() {
        if let currentUser = UserDefaultsUtil.shared.getCurrentUser() {
            user = currentUser
        }
    }
    
}
