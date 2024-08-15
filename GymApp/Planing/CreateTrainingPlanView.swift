//
//  CreateTrainingPlanView.swift
//  GymApp
//
//  Created by Martin Novak on 02.08.2024..
//

import SwiftUI

struct CreateTrainingPlanView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @ObservedObject private var viewModel = CreateTrainingPlanViewModel()
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Create training plan")
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                
                HStack {
                    Text("Enter plan name")
                        .foregroundStyle(.gray)
                    Spacer()
                }
                TextField("", text: $viewModel.planName)
                    .keyboardType(.numberPad)
                    .modifier(OutterShadow())
                    
                HStack {
                    Text("Enter plan description")
                        .foregroundStyle(.gray)
                    Spacer()
                }
                TextField("", text: $viewModel.description)
                    .keyboardType(.numberPad)
                    .modifier(OutterShadow())
                
                PrimaryButton(buttonTitle: "Create plan") {
                    viewModel.createTrainingPlan { success in
                        if success {
                            showAlert = true
                        }
                    }
                }
                .alert("Plan Created", isPresented: $showAlert) {
                    Button("OK") {
                       dismiss()
                    }
                }
                .padding(.top)
            }
            .frame(maxWidth: .infinity)
            .modifier(OutterShadow())
            .padding()
            Spacer()
        }
    }
}

#Preview {
    CreateTrainingPlanView()
}
