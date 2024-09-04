import SwiftUI

struct ThumbRect: View {
  var height: CGFloat = 28.0
  var width: CGFloat = 10.0
  var depth: Bool = true
  
  var body: some View {
    RoundedRectangle(cornerSize: CGSize(width: 3, height: 3))
      .fill(.foreground)
      .frame(width: width, height: height)
      .shadow(radius: 2)
      .overlay {
        if depth {
          LinearGradient(
            gradient: Gradient(colors: [.clear, .black.opacity(0.3)]),
            startPoint: .top,
            endPoint: .bottom
          )
          .clipShape(RoundedRectangle(cornerSize: CGSize(width: 3, height: 3)))
        }
      }
  }
}

#Preview {
  ThumbRect()
    .foregroundStyle(.white)
}
