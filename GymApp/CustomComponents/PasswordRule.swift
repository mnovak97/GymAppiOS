//
//  PasswordRule.swift
//  GymApp
//
//  Created by Martin Novak on 20.07.2024..
//

import SwiftUI

struct PasswordRule: View {
    var rule: String
    var isSatisfied: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isSatisfied ? "checkmark.circle.fill" : "x.circle.fill")
                .foregroundColor(isSatisfied ? .green : .red)
            Text(rule)
                .foregroundStyle(isSatisfied ? .green : .red)
            Spacer()
        }
    }
}

#Preview {
    PasswordRule(rule: "Must be 8 characters long", isSatisfied: false)
}
