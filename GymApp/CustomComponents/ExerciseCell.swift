//
//  ExerciseCell.swift
//  GymApp
//
//  Created by Martin Novak on 21.07.2024..
//

import SwiftUI

struct ExerciseCell: View {
    var name: String
    var systemName: String
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Image(systemName: systemName)
        }
        .modifier(OutterShadow())
        .padding([.leading, .trailing])
    }
}

#Preview {
    ExerciseCell(name: "a", systemName: "a")
}
