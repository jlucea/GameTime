//
//  EmptyView.swift
//  GameTime
//
//  Created by Jaime Lucea on 27/9/24.
//

import SwiftUI

struct EmptyView: View {
    
    private let titleText = "Welcome to GameTime"
    private let subtitleText = "Setup a timer to begin"
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "clock")
            
            Text(titleText)
                .font(.system(size: 28))
                .padding()
            
            Text(subtitleText)
                .font(.subheadline)
                .padding()
            
            //TODO: Add button ("New timer")
            
            Spacer()
        }
        .padding(.bottom, 20)
    }
    
}

#Preview {
    EmptyView()
}
