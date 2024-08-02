//
//  LogExerciseView.swift
//  GymApp
//
//  Created by Martin Novak on 22.07.2024..
//

import SwiftUI

struct LogExerciseView: View {
    @State var exercise: Exercise
    @State private var weightString: String = ""
    @State private var weightInt: Int? = nil
    @State private var repsString: String = ""
    @State private var repsInt: Int? = nil
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
                TextField("", text: $weightString)
                    .keyboardType(.numberPad)
                    .onChange(of: weightString) { newValue, _ in
                        filterWeight(newValue)
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
                TextField("", text: $repsString)
                    .keyboardType(.numberPad)
                    .onChange(of: repsString) { newValue, _ in
                        filterReps(newValue)
                    }
                    .frame(width: 50)
                    .modifier(OutterShadow())
                    .padding(.leading)
                Spacer()
            }
            PrimaryButton(buttonTitle: "Log the exercise") {
                
            }
            .padding(.top)
            Spacer()
        }
    }
    
    private func filterWeight(_ value: String) {
        if let intValue = Int(value) {
            self.weightInt = intValue
        } else {
            self.weightInt = nil
        }
        self.weightString = value.filter {"0123456789".contains($0)}
    }
    
    private func filterReps(_ value: String) {
        if let intValue = Int(value) {
            self.repsInt = intValue
        } else {
            self.repsInt = nil
        }
        self.repsString = value.filter {"0123456789".contains($0)}
    }
}

#Preview {
    LogExerciseView(exercise: Exercise(exerciseId: 1, name: "Pull-up", category: "Core", userExercises: [], trainingPlanExercises: []))
}
