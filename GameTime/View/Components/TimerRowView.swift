
import SwiftUI

struct TimerRowView: View {
    
    /// The timer object to display
    @ObservedObject var timer: GTTimer
    
    @Environment(\.editMode) private var editMode
    @EnvironmentObject var timerManager: GTTimerManager
    
    //MARK: Body
    
    var body: some View {
        HStack (alignment: .center, spacing: 28) {
            if editMode?.wrappedValue.isEditing == true {
                Button(action: {
                    timerManager.deleteTimer(timer)
                }) {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .foregroundStyle(.white, .black, .red)
                        .frame(width: 25, height: 25)
                }
            }
            
            VStack (alignment: .leading, spacing: 5) {
                // Label
                Text(timer.name)
                    .font(.system(size: 18))
                    .foregroundStyle(timer.color)
                    
                // Time
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

//MARK: - Preview

#Preview("Row") {
    var timerOne = GTTimer(name: "Chufo", color: .green, maxTime: 6155)
    TimerRowView(timer: timerOne)
        .padding(40)
        .onAppear {
            timerOne.timeRemaining = 2500
        }
        .environment(\.editMode, .constant(.active))
}

#Preview("List") {
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
