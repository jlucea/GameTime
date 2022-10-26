//
//  TimerCard.swift
//  GameTime
//
//  Created by Jaime Lucea on 15/10/22.
//

import SwiftUI

struct TimerCard: View {
    
    @ObservedObject var timer : PlayerClock
    
    var body: some View {
        
        VStack {
            // Player name
            Text(timer.name)
                .padding()
            
            // Time remaining
            Text(timer.getTimeString())
                .font(.title2)
                .padding()
        }
        .frame(width: 210, height: 210, alignment: .center)
        .border(.gray)
        // .cornerRadius(20)
    }
}


struct TimerCard_Previews: PreviewProvider {
    
    static var previews: some View {
        let previewClock : PlayerClock = PlayerClock(name: "Player #3", color: .orange, maxTime: 6155)
        TimerCard(timer: previewClock)
            .previewDevice(.none)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Timer card")
    }
}
