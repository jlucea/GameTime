//
//  ContentView.swift
//  GameTime
//
//  Created by Jaime Lucea on 15/10/22.
//

import SwiftUI

struct GameTimeView: View {
    
    //
    // Instance of the controller class, that will be responsible for managing timers and their states.
    // This object is made available to other views and subviews as an @EnvironmentObject
    //
    @ObservedObject var timerManager = StateController()
    
    @State private var showAddNewTimerScreen : Bool = false
    
    private let toolbarTitle = "GameTime"
    private let titleText = "Welcome to GameTime"
    private let subtitleText = "Setup a timer to begin"
    
    var body: some View {
        
        ZStack {
            // When runninng under iOS16, could use NavigationStack instead of NavigationView
            NavigationView {
                VStack {
                    if (timerManager.isEmpty()) {
                        // Show message, inviting the user to setup a timer
                        Spacer()
                        Image(systemName: "clock")
                        Text(titleText)
                            .font(.system(size: 32))
                            .padding()
                        Text(subtitleText)
                            .font(.subheadline)
                            .padding()
                        Spacer()
                        
                    } else {
                        // Display active timer and controls
                        TimerControlView(timer: timerManager.activeTimer)
                    }
                    
                    // Horizontal scroll bar at the bottom of the screen
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(timerManager.timers, id: \.id) { timer in
                                TimerCard(timer: timer)
                                    .padding(.trailing, 8)
                            }
                        }
                        .padding(.leading)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // TODO: encapsulate this code defining the toolbar content
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            showAddNewTimerScreen.toggle()
                        }, label: {
                            Image(systemName: "person.crop.circle.badge.plus")
                        })
                        .padding(.bottom, 6)
                        .popover(isPresented: $showAddNewTimerScreen, content: {
                            NewTimerScreen(isPresented: $showAddNewTimerScreen)
                        } )
                    }
                    ToolbarItem(placement: .principal) {
                        Text(toolbarTitle).font(.headline)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Edit", action: {
                            // TODO: remove a timer
                            print("Edit button pressed")
                        })
                    }
                }
            }
            .navigationViewStyle(.stack)
            .environmentObject(timerManager)
            
            // New timer screen view, presented as a sheet
//            .sheet(isPresented: $showAddNewTimerScreen) {
//                NewTimerScreen(isPresented: $showAddNewTimerScreen)
//                    .background(Color.black)
//            }
//            .environmentObject(timerManager)
            
        } // ZStack closure
        
    } // End of view's body
    
}

struct ContentView_Previews: PreviewProvider {
        
    static var previews: some View {
        
        let timer1 = PlayerClock(name: "Jaime", color: .brown, maxTime: 3044)
        let timer2 = PlayerClock(name: "Mª Antonia", color: .yellow, maxTime: 6375)
        let timer3 = PlayerClock(name: "Fco. Javier", color: .blue, maxTime: 7971)
        let timer4 = PlayerClock(name: "Didi", color: .green, maxTime: 3829)
        
        let array : [PlayerClock] = [timer1, timer2, timer3, timer4]
        
        let envObject : StateController = StateController(timers: array, activeTimerIndex: 1)
                        
        return GameTimeView(timerManager: envObject)
            .previewDevice(PreviewDevice(rawValue: "iPad (9th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
            .previewDisplayName("GameTime - Main View (Session Ongoing)")
    }
}
