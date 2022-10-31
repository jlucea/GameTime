//
//  TimerControlView.swift
//  GameTime
//
//  Created by Jaime Lucea on 24/10/22.
//

import SwiftUI

struct ActiveTimerView: View {
    
    @EnvironmentObject var controller : StateController
    
    //
    // This View could perfectly get the active timer from controller. Instead, it uses an observed property timer.
    //
    // This observed property would be needed even if the values displayed
    //  on the view elements were taken from the controller (controller.activeTimer.name)!
    //
    @ObservedObject var timer : PlayerTimer
    
    private let button_size = CGFloat(66)
    
    var body: some View {
        
        ZStack {
            
            CircularProgressView(color: timer.color
                                 , progress: timer.getProgress())
            .frame(width: 400, height: 400)
            
            // Vertical stack containing player name, active timer and timer controls
            VStack {
                Spacer()
                Text(timer.name)
                    .font(.system(size: 32))
                    .foregroundColor(timer.color)
                    .padding()
                
                Text(timer.getTimeString())
                    .font(.custom("Corsiva Hebrew", size: 58, relativeTo: .title))
                    .padding(.bottom, 50)
                
                // Display timer controls
                HStack {
                    Button (action: {
                        // start/pause active timer
                        if (timer.isPaused) {
                            print("PLAY timer \(timer.name): \(timer.remainingSeconds) seconds left")
                            timer.start()
                        } else {
                            print("PAUSE timer \(timer.name): \(timer.remainingSeconds) seconds left")
                            timer.pause()
                        }
                    }, label: {
                        if (timer.isPaused) {
                            Image(systemName: "play.circle")
                                .resizable()
                                .frame(width: button_size, height: button_size)
                                .tint(.white)
                        } else {
                            Image(systemName: "pause.circle")
                                .resizable()
                                .frame(width: button_size, height: button_size)
                                .tint(.white)
                        }
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
                        if (controller.timers.count > 1) {
                            controller.objectWillChange.send()
                            controller.next()
                        }
                    }, label: {
                        Image(systemName: "arrow.right.circle")
                            .resizable()
                            .frame(width: button_size, height: button_size)
                            .tint(.white)
                    })
                }
                Spacer()
            } // VStack
        
        } // ZStack
    } // View
} // Struct

struct TimerControlView_Previews: PreviewProvider {

    static var previews: some View {
        ActiveTimerView(timer: PlayerTimer(name: "Fco. Javier", color: .blue, maxTime: 2199))
            .previewLayout(.sizeThatFits)
            .previewDevice(PreviewDevice(rawValue: "iPad (9th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }

}
