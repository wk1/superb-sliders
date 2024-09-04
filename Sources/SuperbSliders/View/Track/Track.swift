import SwiftUI

struct Track: View {
  
  var height: CGFloat? = nil
  var value: CGFloat? = nil
  
  var body: some View {
    ZStack {
      if value == nil {
        Capsule()
          .fill(Color.primary.opacity(0.2))
      } else {
        Capsule()
          .fill(.tint)
      }
    }
    .frame(width: value, height: height)
  }
}

#Preview {
  ZStack(alignment: .leading) {
    Track(height: 8)
    Track(height: 8, value: 200)
      .tint(.yellow)
  }
  .highlightFrame()
  .padding()
}
