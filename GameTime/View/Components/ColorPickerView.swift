//
//  ColorPickerView.swift
//  GameTime
//
//  Created by Jaime Lucea on 4/11/24.
//

import SwiftUI

private struct CircularColorOptionView: View {
    
    let color: Color
    
    @Binding var isSelected: Bool
    
    var body: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundStyle(color)
            .overlay(
                Circle()
                    .stroke(.white, lineWidth: isSelected ? 2 : 0)
                    .padding(-3)
            )
    }
}

/// A SwiftUI view that presents a grid of selectable colors for the user.
///
/// `ColorPickerView` displays a set of color options in a grid format, allowing the user to
/// pick a color, which is then bound to an external `selectedColor` property. An optional
/// action can be triggered whenever a color is selected.
///
/// - Properties:
///   - selectedColor: A binding to the currently selected color, allowing changes to be
///     reflected outside this view.
///   - onSelectedAction: An optional closure that is executed each time a color is selected.
///   - colorSet: A predefined array of colors available for selection. Defaults to a
///     standard set of colors, including `.yellow`, `.red`, `.blue`, and others.
///   - colorsPerRow: The number of colors displayed per row in the grid. Defaults to `5`.
public struct ColorPickerView: View {
    
    @Binding var selectedColor: Color
    
    var onSelectedAction: (() -> Void)? = nil
    
    var colorSet: [Color] = [.yellow, .red, .blue, .green, .gray, .white, .orange, .purple, .brown, .mint]
    var colorsPerRow: Int = 5
    
    public var body: some View {
        VStack (spacing: 18) {
            ForEach(colorSet.chunked(into: colorsPerRow), id: \.self) { colorRow in
                HStack (spacing: 14) {
                    ForEach(colorRow, id: \.self) { color in
                        CircularColorOptionView(
                            color: color,
                            isSelected: Binding(
                                get: { color == selectedColor },
                                set: { _ in }  // No action needed in set
                            )
                        )
                        .onTapGesture {
                            selectedColor = color
                            self.onSelectedAction?()
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
