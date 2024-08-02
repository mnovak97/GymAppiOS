//
//  GymAppApp.swift
//  GymApp
//
//  Created by Martin Novak on 17.07.2024..
//

import SwiftUI

@main
struct GymAppApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            if viewModel.currentUser == nil {
                LoginPage()
                    .environmentObject(viewModel)
            } else {
                ContentView()
                    .environmentObject(viewModel)
            }
        }
    }
}
