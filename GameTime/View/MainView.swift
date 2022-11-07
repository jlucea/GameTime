//
//  ContentView.swift
//  GameTime
//
//  Created by Jaime Lucea on 15/10/22.
//

import SwiftUI

struct MainView: View {
    
    //
    // Instance of the controller class, that will be responsible for managing timers and their states.
    // This object is made available to other views and subviews as an @EnvironmentObject
    //
    @ObservedObject var controller = StateController()
    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var showAddNewTimerScreen : Bool = false
        
    private let toolbarTitle = "GameTime"
    private let titleText = "Welcome to GameTime"
    private let subtitleText = "Setup a timer to begin"
    
    var body: some View {
        
        // When runninng under iOS16, could use NavigationStack instead of NavigationView
        NavigationView {
            VStack {
                if (controller.timers.isEmpty) {
                    // Empty (no timers) view:
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
                    ActiveTimerView(timer: controller.activeTimer!)
                }
                
                // Horizontal scroll bar at the bottom of the screen
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(controller.timers, id: \.id) { timer in
                            TimerCard(timer: timer)
                                .padding(.trailing, 8)
                        }
                    }
                }
                .padding(.leading)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showAddNewTimerScreen.toggle()
                    }, label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                    })
                    .padding(.bottom, 6)
                    .popover(isPresented: $showAddNewTimerScreen, content: {
                        NewTimerView()
                    } )
                }
                ToolbarItem(placement: .principal) {
                    Text(toolbarTitle).font(.headline)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    // Pressing this button will activate editMode
                    EditButton()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .environmentObject(controller)
        .onChange(of: scenePhase) { newPhase in
            //
            // This code will be executed whenever the app changes phase.
            // In case the app enters background mode while a timer is active,
            // the timer should still discount the time passed when the app becomes active again.
            // In order to achieve this, we will:
            //   1. store the current time when the app enters background mode
            //   2. recover that time when the app becomes active again
            //   3. discount from the timer the time that has passed while being in the background
            //
            if newPhase == .active {
                // print("GameTime - Active")
                
                if (controller.timers.isEmpty == false) {
                    if let activeTimer = controller.activeTimer {
                        if (activeTimer.isPaused == false && activeTimer.remainingSeconds > 0) {
                            print("GameTime becoming active while timer is running")
                            print("Recovering background time")
                            if let backgroundDate : Date = UserDefaults.standard.object(forKey: "backgroundTime") as? Date {
                                
                                let secondsInBackground : TimeInterval = Date.now.timeIntervalSince(backgroundDate)
                                let formatter = DateComponentsFormatter()
                                formatter.allowedUnits = [.second]
                                print("App was in the background for \(formatter.string(from: secondsInBackground)!) seconds")
                                
                                if (Int(secondsInBackground) >= activeTimer.remainingSeconds) {
                                    activeTimer.remainingSeconds = 0
                                    activeTimer.pause()
                                } else {
                                    // Subtract from active timer the time passed since the app entered background
                                    activeTimer.remainingSeconds -= Int(secondsInBackground)
                                }
                            }
                        }
                    }
                }
                // Clear userDefaults
                UserDefaults.standard.removeObject(forKey: "backgroundTime")
                
            } else if newPhase == .inactive {
                // print("GameTime - Inactive")
            } else if newPhase == .background {
                // print("GameTime - Background")
                if let activeTimer = controller.activeTimer {
                    if (activeTimer.isPaused == false) {
                        print("GameTime entering background mode while timer is running")
                        print("Storing time")
                        print("\(Date.now.description)")
                        // Store the Date when the app went into background
                        UserDefaults.standard.set(Date.now, forKey: "backgroundTime")
                    }
                }
            }
        }

        // New timer screen view, presented as a sheet
        // This would have to go inside a ZStack
//        .sheet(isPresented: $showAddNewTimerScreen) {
//            NewTimerScreen(isPresented: $showAddNewTimerScreen)
//                .background(Color.black)
//        }
//        .environmentObject(timerManager)
        
    } // End of view's body
    
}

struct ContentView_Previews: PreviewProvider {
        
    static var previews: some View {
        
        let timer1 = PlayerTimer(name: "Jaime", color: .brown, maxTime: 3044)
        let timer2 = PlayerTimer(name: "Mª Antonia", color: .yellow, maxTime: 6375)
        let timer3 = PlayerTimer(name: "Fco. Javier", color: .blue, maxTime: 7971)
        let timer4 = PlayerTimer(name: "Didi", color: .green, maxTime: 3829)
        let array : [PlayerTimer] = [timer1, timer2, timer3, timer4]
        
        let envObject : StateController = StateController(timers: array, activeTimerIndex: 1)
                        
        return MainView(controller: envObject)
            .previewDevice(PreviewDevice(rawValue: "iPad (9th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
            .previewDisplayName("GameTime - Main View (Session Ongoing)")
    }
}
