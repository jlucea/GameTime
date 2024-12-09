
import SwiftUI

extension CreateTimerView {
    
    class ViewModel: ObservableObject {
        
        @Published var name: String = ""
        @Published var color: Color = .blue
        @Published var time: [Int] = [0, 30, 0]
        
        @Binding var isPresented: Bool
        
        var manager: GTTimerManager?
        
        // Constructor with a binding to close the View upon saving
        init(isPresented: Binding<Bool>, _ timerManager: GTTimerManager? = nil) {
            self._isPresented = isPresented
            self.manager = timerManager
        }
        
        func saveAndClose() {
            
            let totalSecondsSelected = 60 * 60 * time[0] + 60 * time[1]
            
            print("Create new timer:")
            print("Name: \(name)")
            print("Duration: \(totalSecondsSelected)")
            print("Color \(color.description)")
            
            // Instantiate and add new timer
            let newTimer = GTTimer(name: name, color: color, maxTime: totalSecondsSelected)
            manager?.addTimer(timer: newTimer)
            
            self.isPresented = false
        }
    }
    
}
