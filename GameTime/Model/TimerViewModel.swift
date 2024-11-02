//
//  Clock.swift
//  GameClock
//
//  Created by Jaime Lucea on 18/8/22.
//

import Foundation
import SwiftUI

class TimerViewModel: ObservableObject {
    
    let id = UUID()
    let name: String
    let color: Color
    
    var timer: Timer?
    let maxTimeSeconds: Int
    
    @Published var isPaused: Bool
    @Published var timeRemaining: Int
        
    init(name: String, color: Color, maxTime: Int){
        self.name = name
        self.color = color
        self.maxTimeSeconds = maxTime
        self.isPaused = true
        self.timeRemaining = maxTimeSeconds
        initTimer()
    }
    
    init(name: String, color: Color, maxTime: Int, remainingTime: Int){
        self.name = name
        self.color = color
        self.maxTimeSeconds = maxTime
        self.isPaused = true
        self.timeRemaining = maxTimeSeconds
        self.timeRemaining = remainingTime
        initTimer()
    }
    
    // Create a persistent timer
    private func initTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
        
        // Ensure it runs in `.common` mode to keep it active during UI interactions
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func start(){
        self.isPaused = false
        print("Player clock '" + name + "' started")
    }
    
    func pause(){
        print("Timer '" + name + "' paused")
        self.isPaused = true
    }
    
    func resume(){
        if isPaused {
            self.isPaused = false
            print("Player clock '" + name + "' resumed")
        }
    }
    
    private func tick() {
        guard !isPaused else { return } // Only decrement if not paused
        DispatchQueue.main.async {
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.pause() // Automatically pause if time runs out
            }
        }
    }
    
    //
    // Returns 0 to 1, where 1 is 100% completion (0 secs left)
    //
    func getProgress() -> Double {
        return 1-Double(timeRemaining)/Double(maxTimeSeconds)
    }
    
    //
    // Returns String representation of current time e.g. 01:04:48
    //
    func getTimeString() -> String {
        let time = TimeInterval(timeRemaining)
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
}
