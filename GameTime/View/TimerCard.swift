//
//  TimerCard.swift
//  GameTime
//
//  Created by Jaime Lucea on 15/10/22.
//

import SwiftUI

struct TimerCard: View {
    
    var body: some View {
        VStack {
            Text("Player Name")
                .padding()
            
            Text("00:00")
                .font(.title)
                .padding()
        }
        .frame(width: 240, height: 280, alignment: .center)
    }
}

struct TimerCard_Previews: PreviewProvider {
    static var previews: some View {
        TimerCard()
    }
}
