import SwiftUI

public struct RangeSlider: View {
  @Binding var currentRange: ClosedRange<Double>
  
  @State private var trackWidth: CGFloat = .zero
  @State private var leadingOffset: CGFloat = .zero
  @State private var trailingOffset: CGFloat = .zero
  @State private var isLongPressed: Bool = false
  @State private var isPulsing: Bool = false
  
  var maxRange: ClosedRange<Double> = 0.0...100.0
  var thumbRadius: CGFloat = 28.0
  var insetTrack: Bool = true
  
  public init(
    currentRange: Binding<ClosedRange<Double>>,
    maxRange: ClosedRange<Double> = 0.0...100.0,
    thumbRadius: CGFloat = 28.0,
    insetTrack: Bool = true
  ) {
    self._currentRange = currentRange
    self.maxRange = maxRange
    self.thumbRadius = thumbRadius
    self.insetTrack = insetTrack
  }
  
  private var trackPadding: CGFloat {
    insetTrack ? thumbRadius / 2 : 0.0
  }
  
  private var trackHeight: CGFloat {
    thumbRadius / 7
  }
  
  private var thumb: some View {
    Circle()
      .fill(Color.white)
      .frame(width: thumbRadius, height: thumbRadius)
      .shadow(radius: 2)
      .scaleEffect(isPulsing ? 1.2 : 1.0)
      .animation(.easeInOut(duration: 0.3), value: isPulsing)
      .zIndex(1.0)
  }
  
  private func toPixels(value: Double) -> CGFloat {
    let relativeValue = (value - maxRange.lowerBound) / maxRange.length
    return trackWidth * relativeValue
  }
  
  private func toValue(pixels: CGFloat) -> Double {
    let relativePixels = pixels / trackWidth
    return maxRange.lowerBound + (maxRange.length * relativePixels)
  }
  
  private var trackBackground: some View {
    RoundedRectangle(cornerRadius: trackHeight/2)
      .fill(Color.primary.opacity(0.2))
      .frame(height: trackHeight)
      .background {
        GeometryReader { trackGeo in
          Color.clear
            .onAppear {
              trackWidth = trackGeo.size.width
              updateOffsets()
            }
        }
      }
      .padding([.leading, .trailing], trackPadding)
  }
  
  private var trackValue: some View {
    RoundedRectangle(cornerRadius: trackHeight/2)
      .fill(.tint)
      .frame(height: trackHeight)
      .padding(.leading, leadingOffset)
      .padding(.trailing, -trailingOffset)
  }
  
  private func updateLeadingOffset(with translation: CGFloat) {
    leadingOffset = min(max(0, leadingOffset + translation), insetTrack ? trackWidth + trailingOffset : trackWidth + trailingOffset - thumbRadius)
  }
  
  private func updateTrailingOffset(with translation: CGFloat) {
    trailingOffset = max(min(0, trailingOffset + translation), insetTrack ? -trackWidth + leadingOffset : -trackWidth + leadingOffset + thumbRadius)
  }
  
  private func startLongPress() {
    isLongPressed = true
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.impactOccurred()
    isPulsing = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      isPulsing = false
    }
  }
  
  private func endLongPress() {
    isLongPressed = false
  }
  
  private func thumbGesture(isLeading: Bool) -> some Gesture {
    SimultaneousGesture(
      LongPressGesture(minimumDuration: 0.5)
        .onEnded { _ in
          startLongPress()
        },
      DragGesture(minimumDistance: 0)
        .onChanged { value in
          let translation = value.translation.width
          if isLeading {
            updateLeadingOffset(with: translation)
            if isLongPressed && leadingOffset > 0 {
              updateTrailingOffset(with: translation)
            }
          } else {
            updateTrailingOffset(with: translation)
            if isLongPressed && trailingOffset < 0 {
              updateLeadingOffset(with: translation)
            }
          }
          updateValues()
        }
        .onEnded { _ in
          endLongPress()
        }
    )
  }
  
  private var leadingThumb: some View {
    thumb
      .gesture(thumbGesture(isLeading: true))
      .offset(x: leadingOffset)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var trailingThumb: some View {
    thumb
      .gesture(thumbGesture(isLeading: false))
      .offset(x: trailingOffset)
      .frame(maxWidth: .infinity, alignment: .trailing)
  }
  
  private func updateValues() {
    currentRange = toValue(pixels: leadingOffset)...toValue(pixels: trailingOffset + trackWidth - (insetTrack ? 0.0 : thumbRadius))
  }
  
  private func updateOffsets() {
    leadingOffset = toPixels(value: currentRange.lowerBound)
    trailingOffset = toPixels(value: currentRange.upperBound) - trackWidth + (insetTrack ? 0.0 : thumbRadius)
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        trackBackground
        trackValue
        leadingThumb
        trailingThumb
      }
    }
    .frame(height: thumbRadius)
  }
}


#Preview {
  struct Preview: View {
    @State private var currentRange: ClosedRange<Double> = -20...80
    private var maxRange: ClosedRange<Double> = -100...100
    
    var body: some View {
      VStack {
        RangeSlider(currentRange: $currentRange, maxRange: maxRange)
          .padding()
        
        Text("Lower Value: \(currentRange.lowerBound, specifier: "%.0f")")
        Text("Upper Value: \(currentRange.upperBound, specifier: "%.0f")")
      }
    }
  }
  
  return Preview()
}
