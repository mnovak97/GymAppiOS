import SwiftUI

struct InnerShadow: ViewModifier {
    var borderColor: Color = .white
    var color: Color = .black
    var radius: CGFloat = 10
    var x: CGFloat = 5
    var y: CGFloat = 5

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 2)
                    .shadow(color: color.opacity(0.2), radius: radius, x: x, y: y)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .white, radius: radius, x: -x, y: -y)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
    }
}
