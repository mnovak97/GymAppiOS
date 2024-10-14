//
//  LogExerciseView.swift
//  GymApp
//
//  Created by Martin Novak on 22.07.2024..
//

import SwiftUI

struct LogExerciseView: View {
    @ObservedObject var viewModel = LogExerciseViewModel()
    @State var exercise: LoggableExercise
    var exerciseId: Int? = nil
    var customExerciseId: Int? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Selected exercise")
                ExerciseCell(name: exercise.name ?? "", systemName: exercise.systemName)
            }
            .padding(.top)
            .padding(.leading)
            
            CustomLabel(labelText: "Select a weight for you exercise", isMandatory: false)
                .padding(.top, 50)
            HStack {
                TextField("", text: $viewModel.weightString)
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.weightString) { newValue, _ in
                        viewModel.filterWeight(newValue)
                    }
                    .frame(width: 50)
                    .modifier(OutterShadow())
                    .padding(.leading)
                Text("Kg")
                Spacer()
            }
            
            CustomLabel(labelText: "Number of reps", isMandatory: false)
                .padding(.top)
            HStack {
                TextField("", text: $viewModel.repsString)
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.repsString) { newValue, _ in
                        viewModel.filterReps(newValue)
                    }
                    .frame(width: 50)
                    .modifier(OutterShadow())
                    .padding(.leading)
                Spacer()
            }
            PrimaryButton(buttonTitle: "Log the exercise", action: {
                viewModel.logUserExercise(exerciseId: exerciseId, customExerciseId: customExerciseId)
            }, isLoading: viewModel.isLoading)
            .padding(.top)
            .padding([.leading, .trailing])
            .onAppear {
                viewModel.onDismiss = {
                    dismiss()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    LogExerciseView(exercise: Exercise(exerciseId: 1, name: "Pull-up", category: "Core", userExercises: [], trainingPlanExercises: []))
}
