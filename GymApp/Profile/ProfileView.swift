//
//  ProfileView.swift
//  GymApp
//
//  Created by Martin Novak on 20.07.2024..
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 2) {
                Text("Profile")
                    .font(.headline)
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(Color.blue)
                    .padding(.leading, 100)
                    .padding(.trailing, 100)
                Text(authViewModel.currentUser?.username ?? "Username")
                    .font(.largeTitle)
                    .padding(.top, 40)
                VStack {
                    NavigationLink {
                        ProfileEditView(editType: .age)
                    } label: {
                        EditProfileComponent(placeholder: "Edit age")
                            .foregroundStyle(.black)
                    }
                    NavigationLink {
                        ProfileEditView(editType: .height)
                    } label: {
                        EditProfileComponent(placeholder: "Edit height")
                            .foregroundStyle(.black)
                    }
                    NavigationLink {
                        ProfileEditView(editType: .weight)
                    } label: {
                        EditProfileComponent(placeholder: "Edit weight")
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                    Button(action: {
                        authViewModel.logOut()
                    }, label: {
                        Text("Log Out")
                            .foregroundStyle(Color.black)
                            .modifier(OutterShadow())
                    })
                    .padding(.bottom, 50)
                }
                .padding(.top, 40)
                Spacer()
            }
        }
    }
}

#Preview {
    ProfileView().environmentObject(AuthViewModel())
}
