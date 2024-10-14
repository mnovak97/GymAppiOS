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
    var viewAction: () -> Void
    var addAction: () -> Void
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(planName)
                        .font(.title2)
                    Spacer()
                }
                HStack {
                    Text(description)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            HStack {
                PrimaryButton(buttonTitle: "View") {
                    viewAction()
                }
                .frame(width: 75)
                PrimaryButton(buttonTitle: "Add") {
                    addAction()
                }
                .frame(width: 75)
            }
        }
        .modifier(OutterShadow())
    }
}

