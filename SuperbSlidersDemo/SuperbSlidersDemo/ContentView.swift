//
//  ContentView.swift
//  SuperbSlidersDemo
//
//  Created by Christian Hoock on 09.09.24.
//

import SwiftUI
import SuperbSliders

struct ContentView: View {
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
        .padding()
      }
    }
  }
}

#Preview {
    ContentView()
}
