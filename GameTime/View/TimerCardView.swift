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

        ZStack{
            CircularProgressView(color: timer.color
                                 , progress: timer.getProgress(), lineWidth: 6)
            .frame(width: 170, height: 170)
            
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
        } // ZStack
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
        .overlay(alignment: .topLeading) {
            if editMode?.wrappedValue.isEditing == true {
                // The delete button will only be displayed when in edit mode
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
        
    } // Body

}


struct TimerCard_Previews: PreviewProvider {
    
    static var previews: some View {
        let previewClock : PlayerTimer = PlayerTimer(name: "Player #3", color: .green, maxTime: 6155)
        TimerCard(timer: previewClock)
            .previewDevice(.none)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Timer card")
    }
}
