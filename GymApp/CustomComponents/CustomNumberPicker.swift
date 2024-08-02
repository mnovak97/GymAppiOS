//
//  CustomNumberPicker.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//

import SwiftUI

struct CustomNumberPicker: View {
    @Binding var number: Int
    @State private var isPickerPresented: Bool = false
    let numbers: [Int]
    let suffix: String
    
    var body: some View {
        HStack {
            TextField("", text: Binding(
                get: { "\(number) \(suffix)" },
                set: { _ in }
            ))
                .disabled(true)
            Image(systemName: "chevron.down")
                .foregroundStyle(Color.gray)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isPickerPresented.toggle()
        }
        .modifier(OutterShadow())
        .padding([.leading, .trailing])
        .sheet(isPresented: $isPickerPresented) {
            VStack {
            Picker("Select a number", selection: $number) {
                ForEach(numbers, id: \.self) { number in
                    Text("\(number)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 200)
                            
                Button("Done") {
                    isPickerPresented = false
                }
                .padding()
            }
        }
    }
}

#Preview {
    CustomNumberPicker(number: .constant(1), numbers: Array(1...100), suffix: "Kg")
}
