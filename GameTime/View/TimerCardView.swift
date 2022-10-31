//
//  TimerCard.swift
//  GameTime
//
//  Created by Jaime Lucea on 15/10/22.
//

import SwiftUI

struct TimerCard: View {
    
    @Environment(\.editMode) private var editMode
    
    @EnvironmentObject var controller : StateController
    
    @ObservedObject var timer : PlayerTimer
    
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
        .overlay{
            // The delete button will only be displayed when in edit mode
            if editMode?.wrappedValue.isEditing == true {
                Button(action: {
                    controller.deleteTimer(timer: timer)
                }) {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .foregroundStyle(.white, .black, .red)
                        .frame(width: 25, height: 25)
                        .padding([.top, .leading])
                }
                .frame(width: cardWidth, height: cardHeight, alignment: .topLeading)
            }
        }
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
        let previewClock : PlayerTimer = PlayerTimer(name: "Player #3", color: .orange, maxTime: 6155)
        TimerCard(timer: previewClock)
            .previewDevice(.none)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Timer card")
    }
}
