//
//  TrainingPlanView.swift
//  GymApp
//
//  Created by Martin Novak on 31.07.2024..
//

import SwiftUI

struct TrainingPlanListView: View {
    @State private var navigateToCreateTrainingPlan = false
    @State private var navigateToExerciseView = false
    @State private var navigateToTrainingPlanExercisesView = false
    @State private var selectedPlan: TrainingPlan? = nil
    @ObservedObject var viewModel = TrainingPlanViewModel()
    var body: some View {
        VStack {
            Text("Training plans")
                .font(.title3)
                .bold()
            VStack {
                ForEach(viewModel.trainingPlans, id: \.planId) { trainingPlan in
                        TrainingPlanView(
                            planName: trainingPlan.planName ?? "",
                            description: trainingPlan.description ?? "",
                            viewAction: {
                                selectedPlan = trainingPlan
                                navigateToExerciseView = true
                        },
                            addAction: {
                                selectedPlan = trainingPlan
                                navigateToTrainingPlanExercisesView = true
                        })
                    .padding([.leading, .trailing])
                }
            }
            .padding(.top)
            Spacer()
            PrimaryButton(buttonTitle: "Create your training plan") {
                navigateToCreateTrainingPlan = true
            }
            .padding([.leading, .trailing])
        }
        .safeAreaPadding(.bottom)
        .onAppear {
            viewModel.loadTrainingPlans()
        }
        .navigationDestination(isPresented: $navigateToCreateTrainingPlan) {
            CreateTrainingPlanView()
        }
        .navigationDestination(isPresented: $navigateToExerciseView) {
            TrainingPlanExerciseListView(trainingPlanId: selectedPlan?.planId ?? 0)
        }
        .navigationDestination(isPresented: $navigateToTrainingPlanExercisesView) {
            TrainingPlanExercisesView(trainingPlan: selectedPlan)
        }
    }
}

#Preview {
    TrainingPlanListView()
}
