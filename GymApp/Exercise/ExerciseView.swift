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
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select exercise")
                    .font(.title3)
                    .bold()
                
                LazyVStack {
                    ForEach(viewModel.exercises, id: \.exerciseId) { exercise in
                        NavigationLink {
                            LogExerciseView(exercise: exercise)
                        } label: {
                            ExerciseCell(name: exercise.name ?? "", systemName: exercise.systemName)
                                .tint(.black)
                        }
                    }
                }
                PrimaryButton(buttonTitle: "Create your own exercise") {
                    navigateToCreateExercise = true
                }
                .padding([.leading, .trailing])
                .navigationDestination(isPresented: $navigateToCreateExercise) {
                    CustomExerciseView()
                }
            }
        }
    }
}

#Preview {
    ExerciseView()
}
