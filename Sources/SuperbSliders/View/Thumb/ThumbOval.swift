import SwiftUI

struct ThumbOval: View {
  var radius: CGFloat = 28.0
  var depth: Bool = false
  
  var body: some View {
    Circle()
      .fill(.foreground)
      .frame(width: radius, height: radius)
      .shadow(radius: 2)
      .overlay {
        if depth {
          LinearGradient(
            gradient: Gradient(colors: [.clear, .black.opacity(0.3)]),
            startPoint: .top,
            endPoint: .bottom
          )
          .clipShape(Circle())
        }
      }
  }
}

#Preview {
  ThumbOval()
    .highlightFrame()
}
