import SwiftUI

public enum ThumbStyle {
  case rect(skeumorph: Bool)
  case square(skeumorph: Bool)
  case oval(skeumorph: Bool)
  case line(skeumorph: Bool)
  
  @ViewBuilder
  var thumb: some View {
    switch self {
    case .rect(let skeumorph):
      let _ = print("style: rect")
      ThumbRect(height: 28, width: 10, depth: skeumorph)
    case .square(let skeumorph):
      let _ = print("style: square")
      ThumbRect(height: 28, width: 28, depth: skeumorph)
    case .oval(let skeumorph):
      let _ = print("style: oval")
      ThumbOval(radius: 28, depth: skeumorph)
    case .line(let skeumorph):
      let _ = print("style: line")
      ThumbRect(height: 28, width: 2, depth: skeumorph)
    }
  }
  
  var width: CGFloat {
    switch self {
    case .rect(_):
      10.0
    case .square(_):
      28.0
    case .oval(_):
      28.0
    case .line(_):
      2
    }
  }
  
  var height: CGFloat {
    switch self {
    case .rect(_):
      28.0
    case .square(_):
      28.0
    case .oval(_):
      28.0
    case .line(_):
      28.0
    }
  }
}

  // TODO: Slider muessten bei rect dann eigentlich auch quadratisch sein. zumindest beim bold style
