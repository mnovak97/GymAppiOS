//
//  PasswordTextField.swift
//  GymApp
//
//  Created by Martin Novak on 17.07.2024..
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var password: String
    @State var isShowingPassword: Bool = false
    
    var body: some View {
        HStack {
            Group {
                if isShowingPassword {
                    TextField("", text: $password)
                }else {
                    SecureField("", text: $password)
                }
            }
            .disableAutocorrection(true)
            .autocapitalization(.none)
            
            Button {
                isShowingPassword.toggle()
            }label: {
                Image(systemName: isShowingPassword ? "eye.fill" : "eye.slash.fill")
            }
        }
        .padding()
        .modifier(InnerShadow(color: .black, radius: 3, x: 3, y: 3))
        .padding([.leading, .trailing])
    }
}

#Preview {
    PasswordTextField(password: .constant(""))
}
