//
//  ExerciseView.swift
//  GymApp
//
//  Created by Martin Novak on 20.07.2024..
//

import SwiftUI

struct ExerciseView: View {
    @ObservedObject var viewModel = ExercisesViewModel()
    @State private var navigateToCreateExercise = false
    var trainingPlanId: Int? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select exercise")
                    .font(.title3)
                    .bold()
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.exercises, id: \.exerciseId) { exercise in
                            NavigationLink {
                                LogExerciseView(exercise: exercise, exerciseId: exercise.exerciseId)
                            } label: {
                                ExerciseCell(name: exercise.name ?? "", systemName: exercise.systemName)
                                    .tint(.black)
                            }
                        }
                    }.padding(.top)
                    
                    VStack {
                        ForEach(viewModel.customExercises, id: \.customExerciseId) { customExercise in
                            NavigationLink {
                                LogExerciseView(exercise: customExercise, customExerciseId: customExercise.customExerciseId)
                            } label: {
                                ExerciseCell(name: customExercise.name ?? "", systemName: customExercise.systemName)
                                    .tint(.black)
                            }
                        }
                    }
                    
                }
                Spacer()
                if trainingPlanId == nil {
                    PrimaryButton(buttonTitle: "Create your own exercise") {
                        navigateToCreateExercise = true
                    }
                    .padding([.leading, .trailing])
                    .padding(.bottom)
                    .navigationDestination(isPresented: $navigateToCreateExercise) {
                                CustomExerciseView()
                    }
                }
            }
        }
        .onAppear {
            if let trainingPlanId = trainingPlanId {
                viewModel.loadExercises(forID: trainingPlanId)
            } else {
                viewModel.loadExercises()
            }
        }
    }
}

#Preview {
    ExerciseView()
}
