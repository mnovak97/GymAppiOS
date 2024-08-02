//
//  AuthViewModel.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var currentUser: User? {
        didSet {
            saveUser()
        }
    }
    @Published var password: String = "" {
        didSet { validateData() }
    }
    @Published var repeatPassword: String = "" {
        didSet { validateData() }
    }
    @Published var username: String = "" {
        didSet { validateData() }
    }
    @Published var email: String = "" {
        didSet { validateData() }
    }
    @Published var firstName: String = "" {
        didSet { validateData() }
    }
    @Published var lastName: String = "" {
        didSet { validateData() }
    }
    @Published var selectedGender: Gender = .male
    @Published var selectedGenderText: String = "" {
        didSet { validateData() }
    }
    @Published var age: Int = 0 {
        didSet { validateData() }
    }
    @Published var weight: Int = 0 {
        didSet { validateData() }
    }
    @Published var height: Int = 0 {
        didSet { validateData() }
    }
    @Published var isFormValid: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    
    init() {
        loadUser()
    }
    
    private let apiClient = ApiClient()
    
    func createUser() {
        isLoading = true
        Task {
            do {
                let user = try await apiClient.createUser(with:User(userId: nil, username: username, passwordHash: password, email: email, firstName: firstName, lastName: lastName, age: age, gender: selectedGender, weight: weight, height: height, userExercises: [], customExercises: [], trainingPlans: []))
                DispatchQueue.main.async {
                    self.currentUser = user
                    self.isLoading = false
                }
            } catch NetworkError.conflict {
                DispatchQueue.main.async {
                    self.errorMessage = NetworkError.conflict.description
                    self.showAlert = true
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "An unexpected error occurred."
                    self.showAlert = true
                    self.isLoading = false
                }
            }
        }
    }
    
    func logInUser(username: String, password: String) {
        isLoading = true
        Task {
            do {
                let user = try await apiClient.loginUser(username: username, password: password)
                DispatchQueue.main.async {
                    self.currentUser = user
                    self.isLoading = false
                }
            } catch NetworkError.unauthorized {
                DispatchQueue.main.async {
                    self.errorMessage = NetworkError.unauthorized.description
                    self.showAlert = true
                    self.isLoading = false
                }
            }
            catch {
                DispatchQueue.main.async {
                    self.errorMessage = "An unexpected error occurred."
                    self.showAlert = true
                    self.isLoading = false
                }
            }
        }
    }
    
    func logOut() {
        UserDefaultsUtil.shared.removeUser()
        self.currentUser = nil
    }
    
    func validateData() {
        isFormValid = 
                    !username.isEmpty &&
                    !password.isEmpty &&
                    !repeatPassword.isEmpty &&
                    password == repeatPassword &&
                    !email.isEmpty &&
                    isValidEmail(email) &&
                    !firstName.isEmpty &&
                    !lastName.isEmpty &&
                    age > 0 &&
                    weight > 0 &&
                    height > 0
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
        
    private func saveUser() {
        UserDefaultsUtil.shared.saveUser(currentUser: currentUser)
    }
    
    private func loadUser() {
        if let loadedUser = UserDefaultsUtil.shared.getCurrentUser() {
            currentUser = loadedUser
        }
    }
    
}
