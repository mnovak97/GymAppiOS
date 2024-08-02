//
//  ProfileEditView.swift
//  GymApp
//
//  Created by Martin Novak on 21.07.2024..
//

import SwiftUI
import Combine

struct ProfileEditView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var editType: EditType
    @State var textField: String = ""
    
    var body: some View {
        VStack (spacing: 30){
            switch editType {
            case .weight:
                numberEditView(placeholder: "Weight:")
            case .height:
                numberEditView(placeholder: "Height:")
            case .age:
                numberEditView(placeholder: "Age:")
            }
            
            PrimaryButton(buttonTitle: "Done") {
                
            }
        }
    }
}

extension ProfileEditView {
    func numberEditView(placeholder: String) -> some View {
        HStack {
            Text(placeholder)
            Spacer()
            TextField("", text: $textField)
                .keyboardType(.numberPad)
                .onReceive(Just(textField)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.textField = filtered
                        }
                }
        }
        .modifier(OutterShadow())
        .padding([.leading, .trailing])
    }
}

#Preview {
    ProfileEditView(editType: .age)
}
