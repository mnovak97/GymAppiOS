//
//  CustomLabel.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import SwiftUI

struct CustomLabel: View {
    var labelText: String
    var isMandatory: Bool
    
    var body: some View {
        HStack {
            Text(labelText)
                .font(.headline)
                .bold()
                .foregroundStyle(Color.black)
            if isMandatory {
                Text("*")
                    .font(.headline)
                    .foregroundStyle(Color.red)
            }
            Spacer()
        }
        .padding(.leading)
    }
}

#Preview {
    CustomLabel(labelText: "Password", isMandatory: true)
}
