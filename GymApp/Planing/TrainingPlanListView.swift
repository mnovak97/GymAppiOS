//
//  TrainingPlanView.swift
//  GymApp
//
//  Created by Martin Novak on 31.07.2024..
//

import SwiftUI

struct TrainingPlanListView: View {
    @State private var navigateToCreateTrainingPlan = false
    @ObservedObject var viewModel = TrainingPlanViewModel()
    var body: some View {
        VStack {
            Text("Training plans")
                .font(.title3)
                .bold()
            LazyVStack {
                ForEach(viewModel.trainingPlans, id: \.planId) { trainingPlan in
                    NavigationLink {
                        
                    } label: {
                        TrainingPlanView(planName: trainingPlan.planName ?? "", description: trainingPlan.description ?? "")
                    }
                    .foregroundStyle(.black)
                    .padding([.leading, .trailing])
                }
            }
            .padding(.top)
            Spacer()
            PrimaryButton(buttonTitle: "Create your training plan") {
                navigateToCreateTrainingPlan = true
            }
            .padding([.leading, .trailing])
            .navigationDestination(isPresented: $navigateToCreateTrainingPlan) {
                CreateTrainingPlanView()
            }
        }
        .safeAreaPadding(.bottom)
        .onAppear {
            viewModel.loadTrainingPlans()
        }
    }
}

#Preview {
    TrainingPlanListView()
}
