//
//  MainView.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            TabView {
                ExerciseView()
                    .tabItem {
                        Image(systemName: "dumbbell")
                    }
                PlaningView()
                    .tabItem {
                        Image(systemName: "calendar.badge.plus")
                    }
                GraphView()
                    .tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
            }
            .tint(Color.blue)
        }
    }
}

#Preview {
    MainView()
}
