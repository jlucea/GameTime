//
//  MainViewController.swift
//  GameTime
//
//  Created by Jaime Lucea on 21/10/22.
//

import Foundation

final class StateController : ObservableObject {
    
    @Published private(set) var timers : [TimerViewModel]
    @Published private(set) var activeTimer : TimerViewModel?
    
    private var activeTimerIndex : Int
    
    init() {
        self.timers = []
        activeTimerIndex = 0
    }
    
    init(timers: [TimerViewModel], activeTimerIndex: Int) {
        self.timers = timers
        self.activeTimerIndex = activeTimerIndex
        self.activeTimer = timers[activeTimerIndex]
    }
    
    func addTimer(timer: TimerViewModel) {
        timers.append(timer)
        if (timers.count == 1) {
            activeTimer = timer
            activeTimerIndex = 0
        }
    }
    
    func next(){
        if (timers.isEmpty == false) {
            print("Pausing timer \(activeTimer!.name)")
            activeTimer!.pause()
            if (activeTimerIndex < timers.count-1 ) {
                activeTimerIndex+=1
            } else {
                // Cicle through timers, activating the first one in the array
                activeTimerIndex=0
            }
            activeTimer = timers[activeTimerIndex]
            print("New active timer = \(activeTimer!.name)")
            if (activeTimer!.timeRemaining > 0 ) {
                activeTimer!.resume()
            }
            
        }
    }
    
    func delete(timer: TimerViewModel) {
        let wasRunning = !timer.isPaused
        if wasRunning {
            timer.pause()
        }
        // If the timer being deleted is the active timer,
        //  activeTimerIndex must be uptated
        if (timer.id == self.activeTimer!.id) {
            activeTimerIndex = 0
            self.activeTimer = timers[0]
        }
        // Remove timer from array
        timers = timers.filter() { $0 !== timer }
        
        // If the deleted timer was running, the new active timer will also resume
        if !timers.isEmpty && wasRunning {
            activeTimer!.resume()
        }
        
        // Note that the deleted timer remains paused and out of the timers array, but still instantated
    }
    
    func makeActive(timer: TimerViewModel) {
        // Find the index of the timer and update activeTimerIndex accordingly
        if let timerIndex = timers.firstIndex(where: { $0.id == timer.id } ) {
            var wasRunning = false
            if let previousActiveTimer = activeTimer {
                if previousActiveTimer.isPaused == false {
                    // Pause the timer that was previously active and running
                    previousActiveTimer.pause()
                    wasRunning = true
                }
            }
            // Update active timer and resume (only if the previous active timer was running)
            activeTimer = timer
            activeTimerIndex = timerIndex
            if (wasRunning == true && activeTimer!.timeRemaining > 0) {
                activeTimer!.resume()
            }
        }
    }
    
    func isActive(timer: TimerViewModel) -> Bool {
        if let timerIndex = timers.firstIndex(where: { $0.id == timer.id } ) {
            return self.activeTimerIndex == timerIndex
        } else {
            return false
        }
    }
    
}
