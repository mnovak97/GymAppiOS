//
//  TrainingPlanView.swift
//  GymApp
//
//  Created by Martin Novak on 15.08.2024..
//

import SwiftUI

struct TrainingPlanView: View {
    let planName: String
    let description: String
    var body: some View {
        VStack {
            HStack {
                Text(planName)
                    .font(.title2)
                Spacer()
            }
            HStack {
                Text(description)
                    .foregroundStyle(.gray)
                Spacer()
            }
        }
        .modifier(OutterShadow())
    }
}

#Preview {
    TrainingPlanView(planName: "Test", description: "tetststststtstststststtstststs")
}
