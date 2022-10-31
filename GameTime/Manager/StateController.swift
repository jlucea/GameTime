//
//  MainViewController.swift
//  GameTime
//
//  Created by Jaime Lucea on 21/10/22.
//

import Foundation

final class StateController : ObservableObject {
    
    @Published var timers : [PlayerClock]
    
    private var activeTimerIndex : Int
    
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
    
    func deleteTimer(timer: PlayerClock) {
        
        let wasRunning = !timer.isPaused
        if wasRunning {
            timer.pause()
        }
        // If the timer being deleted is the active timer,
        //  activeTimerIndex must be uptated
        if (timer.id == activeTimer.id) {
            activeTimerIndex = 0
        }
        // Remove timer from array
        timers = timers.filter() { $0 !== timer }
        
        // If the timer was running
        if !timers.isEmpty && wasRunning {
            activeTimer.resume()
        }
        
        // Note that timer remains paused and out of the timers array, but still instantated
    }
    
}
