//
//  GenderPicker.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import SwiftUI

struct GenderPicker: View {
    @Binding var selectedGender: Gender
    @Binding var text: String
    @State private var showDialog = false
    
    private let genderOptions: [(Gender, String)] = [
        (.male, "Male"),
        (.female, "Female")
    ]
    
    var body: some View {
        HStack {
            TextField("", text: $text)
                .disabled(true)
            Image(systemName: "chevron.down")
                .foregroundStyle(Color.gray)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showDialog = true
        }
        .confirmationDialog("Gender",isPresented: $showDialog) {
            ForEach(genderOptions, id: \.0) { option in
                Button(option.1) {
                    self.selectedGender = option.0
                    self.text = option.1
                }
            }
            Button("Cancel", role: .cancel) {}
            
        } message: {
            Text("Select gender")
        }
        .modifier(OutterShadow())
        .padding([.leading, .trailing])
    }
}

#Preview {
    GenderPicker(selectedGender: .constant(.male), text: .constant(""))
}
