//
//  NewTimerScreen.swift
//  GameTime
//
//  Created by Jaime Lucea on 20/10/22.
//

import SwiftUI

struct NewTimerScreen: View {
    
    @EnvironmentObject var timerController : StateController
    
    @State private var timeInterval = TimeInterval(60 * 30)
    @State private var playerName : String = ""
    
    @Binding var isPresented : Bool
    
    private let button_size = CGFloat(66)
    
    var body: some View {
        
        VStack {
            
            TextField("Player name", text: $playerName)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
                .frame(width: 300, alignment: .center)
            
            // TODO: Add color picker
            
            TimeDurationPicker(duration: $timeInterval)
                .padding()
            
            Button {
                print("Add new timer button pressed")
                print("New player name: \(playerName)")
                print("Time interval: \(timeInterval)")

                let newTimer = PlayerClock(name: playerName, color: .cyan, maxTime: Int(timeInterval))
                timerController.addTimer(timer: newTimer)
                
                // Dismiss view
                isPresented = false
                
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: button_size, height: button_size)
                    .tint(.green)
            }
            
        }
    }
    
}

struct NewTimerScreen_Previews: PreviewProvider {
    
    struct PreviewContainer : View {
        
        @State private var doDisplay : Bool = true
        
        var body: some View {
            NewTimerScreen(isPresented: $doDisplay)
        }
    }
    
    static var previews: some View {
        PreviewContainer()
    }
}
