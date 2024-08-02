//
//  ContentView.swift
//  GymApp
//
//  Created by Martin Novak on 17.07.2024..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

#Preview {
    ContentView().environmentObject(AuthViewModel())
}
