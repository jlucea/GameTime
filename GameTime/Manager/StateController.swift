//
//  MainViewController.swift
//  GameTime
//
//  Created by Jaime Lucea on 21/10/22.
//

import Foundation

final class StateController : ObservableObject {
    
    @Published var timers : [PlayerClock]
        
    var activeTimerIndex : Int
    
    var activeTimer : PlayerClock {
        return timers[activeTimerIndex]
    }
    
    init(){
        self.timers = []
        activeTimerIndex = 0
    }
    
    init(timers: [PlayerClock], activeTimerIndex: Int) {
        self.timers = timers
        self.activeTimerIndex = activeTimerIndex
    }
    
    func addTimer(playerName: String, seconds: Int) {
        
        let newTimer = PlayerClock(name: playerName, color: .green, maxTime: seconds)
        timers.append(newTimer)
    }
    
    func addTimer(timer: PlayerClock) {
        timers.append(timer)
    }
    
    func getActiveTimer() -> PlayerClock? {
        return timers[activeTimerIndex]
    }
    
    func isEmpty() -> Bool {
        return timers.isEmpty
    }
    
    func next(){
        if (timers.isEmpty == false) {
            print("Pausing timer \(activeTimer.name)")
            activeTimer.pause()
            if (activeTimerIndex < timers.count-1 ) {
                activeTimerIndex+=1
            } else {
                // Cicling through timers
                activeTimerIndex=0
            }
            print("new activeTimerIndex = \(activeTimerIndex)")
            print("Resuming timer \(activeTimer.name)")
            activeTimer.resume()
        }
        print("new activeTimerIndex = \(activeTimerIndex)")
    }
    
}
