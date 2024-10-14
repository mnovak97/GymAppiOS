//
//  TrainingPlanExerciseListView.swift
//  GymApp
//
//  Created by Martin Novak on 03.10.2024..
//

import SwiftUI

struct TrainingPlanExerciseListView: View {
    @ObservedObject var viewModel =  TrainingPlanExerciseListViewModel()
    var trainingPlanId: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Training plan exercises")
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
            }
            .onAppear {
                if viewModel.customExercises.isEmpty && viewModel.exercises.isEmpty {
                    viewModel.fetchExercises(for: trainingPlanId)
                }
            }
        }
    }
}

#Preview {
    TrainingPlanExerciseListView(trainingPlanId: 1)
}
