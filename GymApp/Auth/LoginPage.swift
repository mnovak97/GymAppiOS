//
//  LoginPage.swift
//  GymApp
//
//  Created by Martin Novak on 17.07.2024..
//

import SwiftUI

struct LoginPage: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Image("gymLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                CustomLabel(labelText: "Username", isMandatory: false)
                CustomTextField(image: "person.fill", inputText: $username)
                CustomLabel(labelText: "Password", isMandatory: false)
                PasswordTextField(password: $password)
                
                NavigationLink(destination: RegisterPage()) {
                    HStack {
                        Spacer()
                        Text("Don't have an account ?")
                            .padding(.trailing)
                    }
                }
                PrimaryButton(buttonTitle: "Login", action: {
                    authViewModel.logInUser(username: username, password: password)
                }, isLoading: authViewModel.isLoading)
                .padding(.top, 10)
                .padding([.leading, .trailing])
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
    LoginPage().environmentObject(AuthViewModel())
}
