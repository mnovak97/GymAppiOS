//
//  CustomOutterShado.swift
//  GymApp
//
//  Created by Martin Novak on 19.07.2024..
//
import SwiftUI

struct OutterShadow: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 0)
    }
}
