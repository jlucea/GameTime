
import SwiftUI

struct MainView: View {
    
    //
    // Instance of the controller class, that will be responsible for managing timers and their states.
    // This object is made available to other views and subviews as an @EnvironmentObject
    //
    @StateObject var controller = GTTimerManager()
    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var showAddNewTimerScreen : Bool = false
        
    private let toolbarTitle = "GameTime"
    
    var body: some View {
        
        // When runninng under iOS16, could use NavigationStack instead of NavigationView
        NavigationView {
            VStack {
                if (controller.timers.isEmpty) {
                    EmptyView()
                } else {
                    // Display active timer and controls
                    ActiveTimerView(timer: controller.activeTimer!, size: UIDevice.current.userInterfaceIdiom == .pad ? .large : .medium)
                        .padding(.horizontal)
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        
                        // Horizontal scroll bar at the bottom of the screen
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(controller.timers, id: \.id) { timer in
                                    TimerCardView(timer: timer)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                        .padding(.leading)
                        
                    } else {
                        
                        List {
                            ForEach(controller.timers, id: \.id) { timer in
                                TimerRowView(timer: timer)
                            }
                        }
                        .listStyle(.plain)
                        .frame(height: 268)
                    }
                    
                }
            }
            .padding(.top, 10)
//            .background(Color.cyan.opacity(0.1))
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showAddNewTimerScreen = true
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                    })
                    .padding(.bottom, 6)
                    .popover(isPresented: $showAddNewTimerScreen, content: {
                        CreateTimerView(isPresented: $showAddNewTimerScreen, controller)
                    } )
                }
                ToolbarItem(placement: .principal) {
                    Text(toolbarTitle).font(.headline)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if !controller.timers.isEmpty {
                        // Pressing this button will activate editMode
                        EditButton()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
//        .navigationViewStyle(.stack)
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
                        if (activeTimer.isPaused == false && activeTimer.timeRemaining > 0) {
                            print("GameTime becoming active while timer is running")
                            print("Recovering background time")
                            if let backgroundDate : Date = UserDefaults.standard.object(forKey: "backgroundTime") as? Date {
                                
                                let secondsInBackground : TimeInterval = Date.now.timeIntervalSince(backgroundDate)
                                let formatter = DateComponentsFormatter()
                                formatter.allowedUnits = [.second]
                                print("App was in the background for \(formatter.string(from: secondsInBackground)!) seconds")
                                
                                if (Int(secondsInBackground) >= activeTimer.timeRemaining) {
                                    activeTimer.timeRemaining = 0
                                    activeTimer.pause()
                                } else {
                                    // Subtract from active timer the time passed since the app entered background
                                    activeTimer.timeRemaining -= Int(secondsInBackground)
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

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
        
    static var previews: some View {
        
        let timer1 = GTTimer(name: "Tyrion", color: .purple, maxTime: 3044, remainingTime: 2101)
        let timer2 = GTTimer(name: "Daenerys", color: .red, maxTime: 6375, remainingTime: 3024)
        let timer3 = GTTimer(name: "Cersei", color: .white, maxTime: 7971, remainingTime: 5505)
        let timer4 = GTTimer(name: "Viserys", color: .yellow, maxTime: 3829, remainingTime: 999)
        let timer5 = GTTimer(name: "Theon", color: .green, maxTime: 3829, remainingTime: 755)
        let array : [GTTimer] = [timer1, timer2, timer3, timer4, timer5]
        
        let envObject : GTTimerManager = GTTimerManager(timers: array, activeTimerIndex: 1)
                        
        return MainView(controller: envObject)
            .previewInterfaceOrientation(.portrait)
            .preferredColorScheme(.dark)
            .previewDisplayName("GameTime - Main View (Session Ongoing)")
            .tint(.white)
    }
}
