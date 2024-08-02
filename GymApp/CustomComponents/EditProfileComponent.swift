//
//  EditProfileComponent.swift
//  GymApp
//
//  Created by Martin Novak on 21.07.2024..
//

import SwiftUI

struct EditProfileComponent: View {
    var placeholder: String
    var body: some View {
        HStack {
            Text(placeholder)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
                .bold()
        }
        .modifier(OutterShadow())
        .padding([.leading, .trailing], 20)
    }
}

#Preview {
    EditProfileComponent(placeholder: "Edit weight")
}
