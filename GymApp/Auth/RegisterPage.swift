//
//  RegisterPage.swift
//  GymApp
//
//  Created by Martin Novak on 17.07.2024..
//

import SwiftUI

struct RegisterPage: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @FocusState private var isRepeatPasswordFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                Text("Register")
                    .font(.headline)
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(Color.blue)
                    .padding(.leading, 100)
                    .padding(.trailing, 100)
                
                CustomLabel(labelText: "Username", isMandatory: true)
                    .padding(.top, 50)
                CustomTextField(image: "person.crop.circle.fill", inputText: $authViewModel.username)
                    .padding(.bottom, 10)
                    
                CustomLabel(labelText: "Password", isMandatory: true)
                PasswordTextField(password: $authViewModel.password)
                    .padding(.bottom, 10)
                    .focused($isPasswordFocused)
    
                CustomLabel(labelText: "Repeat password", isMandatory: true)
                PasswordTextField(password: $authViewModel.repeatPassword)
                    .padding(.bottom, 10)
                    .focused($isRepeatPasswordFocused)
                
                
                if isRepeatPasswordFocused && authViewModel.password != authViewModel.repeatPassword {
                    HStack {
                        Spacer()
                        Text("Passwords are not the same")
                            .foregroundStyle(Color.red)
                            .padding(.trailing)
                    }
                }
                if isPasswordFocused {
                    VStack {
                        PasswordRule(rule: "Must be 8 characters long", isSatisfied: authViewModel.password.count >= 8)
                        PasswordRule(rule: "Must include a number", isSatisfied: authViewModel.password.rangeOfCharacter(from: .decimalDigits) != nil)
                        PasswordRule(rule: "Must include a special character", isSatisfied: authViewModel.password.rangeOfCharacter(from: .punctuationCharacters) != nil)
                    }
                    .modifier(OutterShadow())
                .padding([.leading, .trailing])
                }
                
                CustomLabel(labelText: "E-mail", isMandatory: true)
                CustomTextField(image: "envelope.fill", inputText: $authViewModel.email)
                    .padding(.bottom, 10)
                    .textInputAutocapitalization(.never)
                   
                CustomLabel(labelText: "First name", isMandatory: true)
                CustomTextField(image: "person.crop.circle.fill", inputText: $authViewModel.firstName)
                    .padding(.bottom, 10)
        
                CustomLabel(labelText: "Last name", isMandatory: true)
                CustomTextField(image: "person.crop.circle.fill", inputText: $authViewModel.lastName)
                    .padding(.bottom, 10)
                
                CustomLabel(labelText: "Gender", isMandatory: true)
                GenderPicker(selectedGender: $authViewModel.selectedGender, text: $authViewModel.selectedGenderText)
                    .padding(.bottom, 10)
                
                CustomLabel(labelText: "Age", isMandatory: true)
                CustomNumberPicker(number: $authViewModel.age, numbers: Array(1...100), suffix: "")
                    .padding(.bottom, 10)
                
                CustomLabel(labelText: "Weight", isMandatory: true)
                CustomNumberPicker(number: $authViewModel.weight, numbers: Array(1...200), suffix: "Kg")
                    .padding(.bottom, 10)
                
                CustomLabel(labelText: "Height", isMandatory: true)
                CustomNumberPicker(number: $authViewModel.height, numbers: Array(50...250), suffix: "Cm")
                
                PrimaryButton(buttonTitle: "Register", action: {
                    authViewModel.createUser()
                }, isLoading: authViewModel.isLoading)
                .disabled(!authViewModel.isFormValid)
                .opacity(authViewModel.isFormValid ? 1.0 : 0.5)
                .padding(.top, 20)
            }
        }
        .alert("Error", isPresented: $authViewModel.showAlert, actions: {
            Button("OK", role: .cancel) { }
        }, message: {
            Text(authViewModel.errorMessage ?? "An error occurred.")
        })
    }
}

#Preview {
    RegisterPage().environmentObject(AuthViewModel())
}
