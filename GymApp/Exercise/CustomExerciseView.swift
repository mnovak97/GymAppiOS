//
//  CustomExerciseView.swift
//  GymApp
//
//  Created by Martin Novak on 21.07.2024..
//

import SwiftUI

struct CustomExerciseView: View {
    @State var exerciseName: String = ""
    @State var category: String = ""
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
            CustomTextField(image: "", inputText: $exerciseName)
                .padding(.bottom, 20)
            
            CustomLabel(labelText: "Category", isMandatory: false)
            CustomTextField(image: "", inputText: $category)
            
            PrimaryButton(buttonTitle: "Create") {
                
            }
            .padding(.top, 20)
            Spacer()
        }
    }
}

#Preview {
    CustomExerciseView()
}
