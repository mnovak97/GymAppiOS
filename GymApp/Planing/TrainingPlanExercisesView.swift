//
//  TrainingPlanExercisesView.swift
//  GymApp
//
//  Created by Martin Novak on 29.08.2024..
//

import SwiftUI

struct TrainingPlanExercisesView: View {
    @ObservedObject var viewModel = TrainingPlanExercisesViewModel()
    var trainingPlan: TrainingPlan? = nil
    
    var body: some View {
        VStack {
            Text("Exercises")
                .font(.title3)
                .bold()
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.exercises, id: \.exerciseId) { exercise in
                        ExerciseCell(name: exercise.name ?? "", systemName: exercise.systemName)
                            .foregroundStyle(viewModel.isSelectedExercise(exerciseId: exercise.exerciseId ?? 0) ? .blue : .black)
                            .bold(viewModel.isSelectedExercise(exerciseId: exercise.exerciseId ?? 0))
                            .onTapGesture {
                                viewModel.toggleSelectionExercise(for: exercise)
                            }
                    }
                }
                .padding(.top)
                LazyVStack {
                    ForEach(viewModel.customExercises, id: \.customExerciseId) { customExercise in
                        ExerciseCell(name: customExercise.name ?? "", systemName: customExercise.systemName)
                            .foregroundStyle(viewModel.isSelectedCustomExercise(exerciseId: customExercise.customExerciseId ?? 0) ? .blue : .black)
                            .bold(viewModel.isSelectedCustomExercise(exerciseId: customExercise.customExerciseId ?? 0))
                            .onTapGesture {
                                viewModel.toggleSelectionCustomExercise(for: customExercise)
                            }
                        
                    }
                }
            }
            .padding(.bottom)
            
            Spacer()
            PrimaryButton(buttonTitle: "Select exercises", action: {
                guard let trainingPlan else { return }
                viewModel.selectExercises(selectedTrainingPlan: trainingPlan)
            }, isLoading: viewModel.isLoading)
            .padding([.leading, .trailing])
        }
    }
}

#Preview {
    TrainingPlanExercisesView()
}
