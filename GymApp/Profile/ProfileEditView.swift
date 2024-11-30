//
//  ProfileEditView.swift
//  GymApp
//
//  Created by Martin Novak on 21.07.2024..
//

import SwiftUI
import Combine

struct ProfileEditView: View {
    @ObservedObject var profileViewModel = ProfileViewModel()
    var editType: EditType
    @State var textField: String = ""
    
    var body: some View {
        VStack (spacing: 30){
            HStack {
                Text("Current \(editType.rawValue.capitalized):")
                switch editType {
                case .weight:
                    Text("\(profileViewModel.user?.weight ?? 0) kg")
                case .height:
                    Text("\(profileViewModel.user?.height ?? 0) cm")
                case .age:
                    Text("\(profileViewModel.user?.age ?? 0)")
                }
            }
            switch editType {
            case .weight:
                numberEditView(placeholder: "Weight:")
            case .height:
                numberEditView(placeholder: "Height:")
            case .age:
                numberEditView(placeholder: "Age:")
            }
            
            PrimaryButton(buttonTitle: "Done") {
                profileViewModel.updateUser(editType: editType, value: Int(textField) ?? 0)
            }
            .padding([.leading, .trailing])
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
