//
//  GameTimeApp.swift
//  GameTime
//
//  Created by Jaime Lucea on 15/10/22.
//

import SwiftUI

@main
struct GameTimeApp: App {
        
    @StateObject var timerManager: GTTimerManager
    
    init() {
        if ProcessInfo.processInfo.isPreloadingTimers {
            _timerManager = StateObject(wrappedValue: GTTimerManager.mocked())
        } else {
            _timerManager = StateObject(wrappedValue: GTTimerManager())
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(timerManager)
                .preferredColorScheme(.dark)
                .tint(.white)
        }
    }
}
