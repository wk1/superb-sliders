import SwiftUI

public struct ValueSlider: View {
  
  @Binding var value: Double
  
  @State private var trackWidth: CGFloat = .zero
  @State private var labelWidth: CGFloat = .zero
  @State private var showLabel: Bool = false
  @State private var thumbFrame: CGRect = .zero
  
  var range: ClosedRange<Double>
  var step: Double
  var trackStyle: TrackStyle
  var thumbStyle: ThumbStyle
  var onEditingChanged: ((Bool) -> Void)?
  
  public init(
    value: Binding<Double>,
    in range: ClosedRange<Double> = 0.0...100.0,
    step: Double = 0.1,
    trackStyle: TrackStyle = .thin(inset: false),
    thumbStyle: ThumbStyle = .oval(skeumorph: false),
    insetTrack: Bool = true,
    onEditingChanged: ((Bool) -> Void)? = nil
  ) {
    self._value = value
    self.range = range
    self.trackStyle = trackStyle
    self.step = step
    self.thumbStyle = thumbStyle
    self.onEditingChanged = onEditingChanged
  }
  
  private var horizontalDrag: some Gesture {
    DragGesture(minimumDistance: 0.0)
      .onChanged { value in
        let newValue = computeNewValue(from: value.location.x, width: trackWidth)
        self.value = newValue
        handleEditing(.changed)
      }
      .onEnded { _ in
        handleEditing(.ended)
      }
  }
  
  private func handleEditing(_ state: EditingState) {
    onEditingChanged?(state == .changed)
    withAnimation {
      showLabel = state == .changed
    }
  }
  
  private func thumbPosition(in width: CGFloat) -> CGFloat {
    CGFloat(range.distance(for: value) / range.length * width)
  }
  
  private func computeNewValue(from thumbPosition: CGFloat, width: CGFloat) -> Double {
    let percentage = max(0, min(1, thumbPosition / width))
    let newValue = Double(percentage) * (range.upperBound - range.lowerBound) + range.lowerBound
    let roundedValue = (newValue / step).rounded() * step
    return min(range.upperBound, max(range.lowerBound, roundedValue))
  }
  
  private var slider: some View {
    ZStack(alignment: .leading) {
      ZStack(alignment: .leading) {
        Track(height: trackStyle.height)
        Track(
          height: trackStyle.height,
          value: trackStyle == .thin(inset: true) || trackStyle == .medium(inset: true) ? thumbPosition(in: trackWidth-thumbStyle.width) : thumbPosition(in: trackWidth-thumbStyle.width) + thumbStyle.width
        )
      }
      .padding([.leading, .trailing], trackStyle.padding(thumb: thumbStyle))
      .readSize(onChange: { size in
        trackWidth = size.width
      })
      
      thumbStyle.thumb
        .offset(x: thumbPosition(in: trackWidth-thumbStyle.width))
        .gesture(horizontalDrag)
    }
    .frame(height: thumbStyle.height)
  }
  
  public var body: some View {
    if trackStyle == .bold {
      slider
        .clipped()
    } else {
      slider
    }
  }
}


#Preview {
  struct Preview: View {
    @State private var value1: Double = 20.0
    @State private var value2: Double = -20.0
    @State private var value3: Double = 40.0
    @State private var value4: Double = 80.0
    @State private var value5: Double = -50.0
    @State private var value6: Double = -40.0
    @State private var value7: Double = -10.0
    private var range: ClosedRange<Double> = -100...100
    
    var body: some View {
      ScrollView {
        VStack(spacing: 0) {
          Group {
            ValueSlider(
              value: $value1,
              in: range,
              trackStyle: .medium(inset: true),
              thumbStyle: .rect(skeumorph: true)
            )
            .tint(.teal)
            
            Text("Value: \(value1, specifier: "%.0f")")
            
            ValueSlider(
              value: $value2,
              in: range,
              trackStyle: .medium(inset: false),
              thumbStyle: .rect(skeumorph: true)
            )
            .tint(.pink)
            .foregroundColor(.white)
            
            Text("Value: \(value2, specifier: "%.0f")")
            
            ValueSlider(
              value: $value3,
              in: range,
              trackStyle: .medium(inset: true),
              thumbStyle: .oval(skeumorph: true)
            )
            .tint(.yellow)
            .foregroundColor(.yellow)
            
            Text("Value: \(value3, specifier: "%.0f")")
            
            ValueSlider(
              value: $value4,
              in: range,
              trackStyle: .bold,
              onEditingChanged: { editing in
                print("Slider 3 Editing? \(editing)")
              }
            )
            .tint(.purple)
            .foregroundColor(.purple)
            
            Text("Value: \(value4, specifier: "%.0f")")
            
            ValueSlider(
              value: $value5,
              in: range,
              trackStyle: .bold,
              onEditingChanged: { editing in
                print("Slider 4 Editing? \(editing)")
              }
            )
            .tint(.mint)
            .foregroundColor(.white.opacity(0.5))
            
            Text("Value: \(value5, specifier: "%.0f")")
            
            ValueSlider(
              value: $value6,
              in: range,
              trackStyle: .thin(inset: false),
              thumbStyle: .line(skeumorph: false),
              onEditingChanged: { editing in
                print("Slider 5 Editing? \(editing)")
              }
            )
            .tint(.mint)
            .foregroundColor(.mint)
            
            Text("Value: \(value6, specifier: "%.0f")")
            
            ValueSlider(
              value: $value7,
              in: range,
              trackStyle: .thin(inset: true),
              thumbStyle: .square(skeumorph: true),
              onEditingChanged: { editing in
                print("Slider 5 Editing? \(editing)")
              }
            )
            .tint(.indigo)
            .foregroundColor(.indigo)
            
            Text("Value: \(value7, specifier: "%.0f")")
          }
          .highlightFrame()
          .padding()
        }
      }
    }
  }
  
  return Preview()
}
