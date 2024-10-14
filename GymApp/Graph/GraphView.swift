//
//  GraphView.swift
//  GymApp
//
//  Created by Martin Novak on 20.07.2024..
//

import SwiftUI

struct GraphView: View {
    @ObservedObject var viewModel = GraphViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(Array(viewModel.groupExercisesById(exercises: viewModel.userExercises).keys), id: \.self) { key in
                    if let exerciseGroup = viewModel.groupExercisesById(exercises: viewModel.userExercises)[key] {
                        let graphData = viewModel.prepareGraphData(for: exerciseGroup)
                        let exerciseName = viewModel.exerciseNames[key] ?? "Exercise"
                        
                        ExerciseGraphView(graphData: graphData, exerciseName: exerciseName)
                            .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    GraphView()
}
