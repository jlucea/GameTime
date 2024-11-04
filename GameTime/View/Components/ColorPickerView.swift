//
//  ColorPickerView.swift
//  GameTime
//
//  Created by Jaime Lucea on 4/11/24.
//

import SwiftUI

private struct CircularColorOptionView: View {
    
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        Circle()
            .frame(width: 42, height: 42)
            .foregroundStyle(color)
            .overlay(
                Circle()
                    .stroke(.white, lineWidth: isSelected ? 2 : 0)
                    .padding(-3)
            )
    }
}

public struct ColorPickerView: View {
    
    @Binding var selectedColor: Color
    
    let colorSet: [Color] = [.yellow, .red, .blue, .green, .gray, .white, .orange, .purple, .brown, .mint]
    let colorsPerRow: Int = 5
    
    public var body: some View {
        VStack (spacing: 22) {
            ForEach(colorSet.chunked(into: colorsPerRow), id: \.self) { colorRow in
                HStack (spacing: 14) {
                    ForEach(colorRow, id: \.self) { color in
                        CircularColorOptionView(color: color, isSelected: color == selectedColor)
                            .onTapGesture {
//                                print("Selected \(color.description)")
                                selectedColor = color
                            }
                    }
                }
            }
        }
    }
}

// Extension to split an array into chunks
public extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

// MARK: - Preview

struct ColorPickerView_Previews: PreviewProvider {
    struct ColorPickerPreviewWrapper: View {
        @State private var selectedColor: Color = .yellow

        var body: some View {
            ColorPickerView(selectedColor: $selectedColor)
        }
    }
    
    static var previews: some View {
        ColorPickerPreviewWrapper()
    }
}
