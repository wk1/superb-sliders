import CoreGraphics

public enum TrackStyle: Equatable {
  case thin(inset: Bool)
  case medium(inset: Bool)
  case bold
  
  var height: CGFloat? {
    switch self {
    case .thin(_):
      return 2.0
    case .medium(_):
      return 4.0
    case .bold:
      return nil
    }
  }
  
  func padding(thumb: ThumbStyle) -> CGFloat {
    switch self {
    case .thin(let inset):
      inset ? thumb.width / 2 : 0.0
    case .medium(let inset):
      inset ? thumb.width / 2 : 0.0
    case .bold:
      0.0
    }
  }
}
