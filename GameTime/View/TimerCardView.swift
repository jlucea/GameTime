//
//  TimerCard.swift
//  GameTime
//
//  Created by Jaime Lucea on 15/10/22.
//

import SwiftUI

struct TimerCard: View {
    
    @ObservedObject var timer : PlayerClock
    
    let cardWidth : CGFloat = 210
    let cardHeight : CGFloat = 210
    
    var body: some View {

        VStack {
            // Player name
            Text(timer.name)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
            // Time remaining
            Text(timer.getTimeString())
                .font(.title2)
                .foregroundColor(.white)
                .padding()
        }
        .frame(width: cardWidth, height: cardHeight, alignment: .center)
        .background {
            if (timer.isPaused) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("GTDarkGrayColor"))
            } else {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.gray)
            }
        }
    }
}


struct TimerCard_Previews: PreviewProvider {
    
    static var previews: some View {
        let previewClock : PlayerClock = PlayerClock(name: "Player #3", color: .orange, maxTime: 6155)
        TimerCard(timer: previewClock)
            .previewDevice(.none)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Timer card")
    }
}
