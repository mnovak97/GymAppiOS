//
//  UserDefaultsUtil.swift
//  GymApp
//
//  Created by Martin Novak on 20.07.2024..
//

import Foundation

class UserDefaultsUtil {
    private let userDefaultsKey = "currentUser"
    
    static let shared = UserDefaultsUtil()
    
    func saveUser(currentUser: User?) {
        if let currentUser = currentUser {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(currentUser)
                UserDefaults.standard.set(data, forKey: userDefaultsKey)
            } catch {
                print("Failed to save user: \(error.localizedDescription)")
            }
        } else {
            UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        }
    }
    
    func removeUser() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }

    func getCurrentUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return nil
        }

        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch {
            print("Failed to load user: \(error.localizedDescription)")
            return nil
        }
    }
}
