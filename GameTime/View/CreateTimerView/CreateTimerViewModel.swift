
import SwiftUI

extension CreateTimerView {
    
    /// ViewModel for the CreateTimerView, responsible for managing the timer creation form.
    class ViewModel: ObservableObject {
        
        /// The name of the timer being created.
        @Published var name: String = ""
        
        /// The color of the timer being created.
        @Published var color: Color = .blue
        
        /// The selected time for the timer in hours, minutes, and seconds.
        @Published var duration: TimerDuration
        
        /// A binding to control the presentation of the CreateTimerView. Setting it to `false` dismisses the view.
        @Binding var isPresented: Bool
        
        /// The timer manager responsible for managing and storing timers. This can be nil if no manager is provided.
        var manager: GTTimerManager?
        
        private static let lastTimerDurationKey: String = "lastTimerDuration"
        
        /// Initializes the ViewModel with a binding to control view dismissal and an optional timer manager.
        /// - Parameters:
        ///   - isPresented: A binding to a Boolean controlling the presentation of the view.
        ///   - timerManager: An optional timer manager to which the new timer will be added.
        init(isPresented: Binding<Bool>, _ timerManager: GTTimerManager? = nil) {
            self._isPresented = isPresented
            self.manager = timerManager
            
            if let lastTimerDuration = UserDefaults.standard.object(forKey: CreateTimerView.ViewModel.lastTimerDurationKey) as? [String: Int] {
                self.duration = TimerDuration(hours: lastTimerDuration["hours"] ?? 0, minutes: lastTimerDuration["minutes"] ?? 0, seconds: lastTimerDuration["seconds"] ?? 0)
            } else {
                self.duration = .init(hours: 0, minutes: 30, seconds: 0)
            }
        }
        
        /// Saves the new timer using the provided details and dismisses the view.
        func saveAndClose() {
            
            let totalSecondsSelected = duration.hours * 3600 + duration.minutes * 60 + duration.seconds
            
            print("Create new timer:")
            print("Name: \(name)")
            print("Duration: \(totalSecondsSelected)")
            print("Color \(color.description)")
            
            // Instantiate and add new timer
            let newTimer = GTTimer(name: name, color: color, maxTime: totalSecondsSelected)
            manager?.addTimer(timer: newTimer)
            
            // Store chosen duration
            let durationDict = ["hours": duration.hours, "minutes": duration.minutes, "seconds": duration.seconds]
            UserDefaults.standard.set(durationDict, forKey: CreateTimerView.ViewModel.lastTimerDurationKey)
            
            self.isPresented = false
        }
                
    }
    
}
