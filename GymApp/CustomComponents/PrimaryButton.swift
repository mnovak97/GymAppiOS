//
//  PrimaryButton.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import SwiftUI

struct PrimaryButton: View {
    var buttonTitle: String
    var action: () -> Void
    var isLoading: Bool = false
    
    var body: some View {
            Button(action: {
                if !isLoading {
                    action()
                }
            }) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                } else {
                    Text(buttonTitle)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .disabled(isLoading)
        }
}

