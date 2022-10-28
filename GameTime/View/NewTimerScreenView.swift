//
//  NewTimerScreen.swift
//  GameTime
//
//  Created by Jaime Lucea on 20/10/22.
//

import SwiftUI

struct NewTimerScreen: View {
    
    @EnvironmentObject var timerController : StateController
    
    @State private var timeInterval = TimeInterval(60 * 30)     // Initial value
    @State private var playerName : String = ""
    
    @Binding var isPresented : Bool
    
    let frameWidth : CGFloat = 350
    let frameHeight : CGFloat = 400
    
    private let button_size = CGFloat(66)
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Player name", text: $playerName)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading, .trailing])
                    .frame(width: 330, alignment: .center)
                
                TimeDurationPicker(duration: $timeInterval)
                    .onSubmit {
                        print("Time duration picker - submit")
                    }
                
                // TODO: Add color picker
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add Player").font(.headline)
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Save", action: {
                        saveAndClose()
                    })
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: {
                        isPresented.toggle()
                    })
                }
            }
        }
        .frame(idealWidth: frameWidth, maxWidth: frameWidth, idealHeight: frameHeight, maxHeight: frameHeight)
        // .border(.green, width: 2)
        .navigationViewStyle(.stack)
    }
    
    func saveAndClose() {
        
        // print("New Player - save button pressed")
        // print("New player name: \(playerName)")
        // print("Time interval: \(timeInterval)")
        let newTimer = PlayerClock(name: playerName, color: .cyan, maxTime: Int(timeInterval))
        timerController.addTimer(timer: newTimer)
        
        // Dismiss view
        isPresented = false
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
