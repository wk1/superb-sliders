import SwiftUI

struct HighlightFrameModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .background(
        Color.pink.opacity(0.1)
          .cornerRadius(4.0)
          .overlay(
            RoundedRectangle(cornerRadius: 4)
              .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
              .foregroundColor(.pink)
              .opacity(0.5)
          )
      )
  }
}

extension View {
  func highlightFrame() -> some View {
    self.modifier(HighlightFrameModifier())
  }
}
