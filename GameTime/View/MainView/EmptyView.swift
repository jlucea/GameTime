//
//  EmptyView.swift
//  GameTime
//
//  Created by Jaime Lucea on 27/9/24.
//

import SwiftUI

struct EmptyView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "clock")
            
            Text(String(localized: "welcome_message"))
                .font(.system(size: 28))
                .padding()
            
            Text(String(localized: "initial_instructions"))
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
