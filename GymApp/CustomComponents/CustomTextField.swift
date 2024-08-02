//
//  CustomTextField.swift
//  GymApp
//
//  Created by Martin Novak on 17.07.2024..
//

import SwiftUI

struct CustomTextField: View {
    var image: String
    @Binding var inputText: String
    
    var body: some View {
        HStack {
            TextField("", text:$inputText)
            Image(systemName: image)
                .foregroundStyle(Color.blue)
        }
        .padding()
        .modifier(InnerShadow(color: .black, radius: 3, x: 3, y: 3))
        .padding([.leading, .trailing])
        
    }
}

#Preview {
    CustomTextField(image: "person.fill", inputText: .constant(""))
}
