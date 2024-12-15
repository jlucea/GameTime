//
//  TimerRowView.swift
//  GameTime
//
//  Created by Jaime Lucea on 10/12/24.
//

import SwiftUI

struct TimerRowView: View {
    
    @ObservedObject var timer: GTTimer
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 5) {
                Text(timer.name)
                    .font(.system(size: 18))
                    .foregroundStyle(timer.color)
                    
                Text(timer.getTimeString())
                    .font(.system(size: 24))
            }
            
            Spacer()
            
            CircularProgressView(color: timer.color, progress: timer.getProgress(), lineWidth: 10)
                .tint(timer.color)
                .frame(width: 36, height: 36)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
    }
}

#Preview {
    var timerOne = GTTimer(name: "Chufo", color: .green, maxTime: 6155)
    var timerTwo = GTTimer(name: "Trufa", color: .pink, maxTime: 6155)
    var timerThree = GTTimer(name: "Mango", color: .red, maxTime: 6155)
    var timerFour = GTTimer(name: "Atún", color: .orange, maxTime: 6155)
    
    List {
        TimerRowView(timer: timerOne)
        TimerRowView(timer: timerTwo)
        TimerRowView(timer: timerThree)
        TimerRowView(timer: timerFour)
    }
    .onAppear {
        timerOne.timeRemaining = 1200
        timerTwo.timeRemaining = 1650
        timerThree.timeRemaining = 2200
        timerFour.timeRemaining = 670
        
    }
}
