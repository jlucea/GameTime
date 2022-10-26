//
//  TimerControlView.swift
//  GameTime
//
//  Created by Jaime Lucea on 24/10/22.
//

import SwiftUI

struct TimerControlView: View {
    
    @EnvironmentObject var controller : StateController
    
    //
    // TimerControlView could perfectly call the controller in order to get the active timer
    //  and display its data. Instead, it uses an observed property timer.
    //
    // This observed property would be needed even if the values displayed
    //  on the view elements were taken from the controller (controller.activeTimer.name)!
    //
    @ObservedObject var timer : PlayerClock
    
    private let button_size = CGFloat(66)
    
    var body: some View {
        
        VStack {
            
            Spacer()
            Text(timer.name)
                .font(.system(size: 32))
                .padding()
            
            Text(timer.getTimeString())
                .font(.custom("Corsiva Hebrew", size: 58, relativeTo: .title))
                .padding(.bottom, 50)
            
            // Display timer controls
            HStack {
                Button (action: {
                    // start/pause active timer
                    if (timer.isPaused) {
                        timer.start()
                    } else {
                        timer.pause()
                    }
                }, label: {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: button_size, height: button_size)
                        .tint(.green)
                })
                .padding(.trailing, 50)

                Button (action: {
                    //
                    // "All observable objects automatically get access to an objectWillChange property,
                    //  which has a send() method we can all whenever we want observing views to refresh."
                    //
                    // We call objectWillChange.sedn() here for the view to be ready to update itself
                    //  when we activate the next timer in the controller.
                    //
                    controller.objectWillChange.send()
                    controller.next()

                }, label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: button_size, height: button_size)
                        .tint(.blue)
                })
            }
            .padding()
            
            Spacer()
        }
    }
    
}

struct TimerControlView_Previews: PreviewProvider {

    static var previews: some View {
        TimerControlView(timer: PlayerClock(name: "Fco. Javier", color: .blue, maxTime: 2199))
            .previewLayout(.sizeThatFits)
    }

}
