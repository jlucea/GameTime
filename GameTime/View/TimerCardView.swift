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
                        
            Text(timer.name)
                .padding()
            
            Text(timer.getTimeString())
                .font(.title)
                .padding()
        }
        .frame(width: 240, height: 280, alignment: .center)
        .border(.gray)
        // .cornerRadius(20)
    }
}


struct TimerCard_Previews: PreviewProvider {
    
    static var previews: some View {
        let previewClock : PlayerClock = PlayerClock(name: "Player", color: .orange, maxTime: 155)
        TimerCard(timer: previewClock)
            .previewDevice(.none)
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Timer card preview")
    }
}
