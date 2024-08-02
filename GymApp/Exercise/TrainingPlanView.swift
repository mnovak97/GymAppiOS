//
//  TrainingPlanView.swift
//  GymApp
//
//  Created by Martin Novak on 31.07.2024..
//

import SwiftUI

struct TrainingPlanView: View {
    var body: some View {
        VStack {
            Text("Training plans")
                .font(.title3)
                .bold()
            Spacer()
            PrimaryButton(buttonTitle: "New training plan") {
                
            }
        }
    }
}

#Preview {
    TrainingPlanView()
}
