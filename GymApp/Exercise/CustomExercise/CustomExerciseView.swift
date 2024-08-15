//
//  CustomExerciseView.swift
//  GymApp
//
//  Created by Martin Novak on 21.07.2024..
//

import SwiftUI

struct CustomExerciseView: View {
    @ObservedObject var viewModel = CustomExerciseViewModel()
    var body: some View {
        VStack {
            Text("Create your own exercise")
                .font(.headline)
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(Color.blue)
                .padding(.leading, 80)
                .padding(.trailing, 80)
            
            Spacer()
            
            CustomLabel(labelText: "Exercise name", isMandatory: false)
            CustomTextField(image: "", inputText: $viewModel.name)
                .padding(.bottom, 20)
            
            CustomLabel(labelText: "Category", isMandatory: false)
            CustomTextField(image: "", inputText: $viewModel.category)
            
            PrimaryButton(buttonTitle: "Create") {
                viewModel.createCustomExercise()
            }
            .padding(.top, 20)
            .padding([.leading, .trailing])
            Spacer()
        }
    }
}

#Preview {
    CustomExerciseView()
}
