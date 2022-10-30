//
//  CircularProgressView.swift
//  GameTime
//
//  Created by Jaime Lucea on 30/10/22.
//

import SwiftUI

struct CircularProgressView: View {
    
    let color : Color
    var progress: Double
    
    private let lineWidth : CGFloat = 20
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    self.color.opacity(0.2),
                    lineWidth: lineWidth
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    self.color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}


struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(color: Color.green, progress: 0.7)
    }
}
