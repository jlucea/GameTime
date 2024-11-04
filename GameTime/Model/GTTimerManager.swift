
import Foundation

/// Manages a collection of `GTTimers`, allowing for adding, deleting, and switching
/// between active timers. The class maintains the concept of an "active" timer, which
/// is simply the timer currently selected. Only one timer can be active at a time,
/// but it may or may not be running. The `GTTimerManager` handles transitions between
/// timers and ensures only one timer is active at any given time.
final class GTTimerManager : ObservableObject {
    
    /// An array of all `GTTimers` managed by this instance.
    /// New timers can be added via `addTimer(timer:)`, and existing timers
    /// can be deleted using `deleteTimer(_:)`.
    @Published private(set) var timers: [GTTimer] = []
    
    /// The currently active `GTTimer`, representing the selected timer.
    /// The active timer is updated when timers are added, deleted, or switched via methods like `activateNextTimer()` and `makeActive(_:)`.
    @Published private(set) var activeTimer: GTTimer?
    
    /// The index of the active timer in the `timers` array. Used internally to keep track of which timer is currently selected.
    private var activeTimerIndex: Int = 0
    
    /// Initializes an empty `GTTimerManager` with no timers.
    init() {}
    
    /// Initializes a `GTTimerManager` with an array of timers and sets an initial active timer.
    ///
    /// - Parameters:
    ///   - timers: An array of `GTTimer` instances to initialize the manager with.
    ///   - activeTimerIndex: The index of the timer to be set as active. Defaults to 0 if out of bounds.
    init(timers: [GTTimer], activeTimerIndex: Int) {
        self.timers = timers
        self.activeTimerIndex = timers.indices.contains(activeTimerIndex) ? activeTimerIndex : 0
        self.activeTimer = timers.indices.contains(activeTimerIndex) ? timers[activeTimerIndex] : nil
    }
    
    /// Adds a new timer to the manager. If this is the first timer being added,
    /// it is set as the active timer.
    ///
    /// - Parameter timer: The `GTTimer` instance to be added to the collection.
    func addTimer(timer: GTTimer) {
        timers.append(timer)
        if (timers.count == 1) {
            activeTimer = timer
            activeTimerIndex = 0
        }
    }
    
    /// Activates the next timer in the array. If the active timer is the last one,
    /// it cycles back to the first timer in the array. The active timer is updated
    /// based on the array's order but may or may not be running.
    func activateNextTimer() {
        guard !timers.isEmpty else { return }
        
        activeTimer?.pause()
        if (activeTimerIndex < timers.count-1 ) {
            activeTimerIndex+=1
        } else {
            // Cicle through timers, activating the first one in the array
            activeTimerIndex=0
        }
        activeTimer = timers[activeTimerIndex]

        if (activeTimer?.timeRemaining ?? 0 > 0 ) {
            activeTimer?.resume()
        }
    }
    
    /// Deletes the specified timer from the collection. If the timer being deleted
    /// is the active timer, the active timer is reset to the first timer in the list.
    /// If the deleted timer was running, the new active timer will resume.
    ///
    /// - Parameter timer: The `GTTimer` instance to be deleted.
    func deleteTimer(_ timer: GTTimer) {
        let wasRunning = !timer.isPaused
        if wasRunning {
            timer.pause()
        }
        // If the timer being deleted is the active timer, update activeTimerIndex
        if (timer.id == self.activeTimer?.id) {
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
    
    /// Sets the specified timer as the active timer, making it the selected timer.
    /// If there was a previously active timer that was running, it is paused, and the
    /// new active timer resumes only if it has remaining time.
    ///
    /// - Parameter timer: The `GTTimer` instance to be made active.
    func makeActive(_ timer: GTTimer) {
        guard let timerIndex = timers.firstIndex(where: { $0.id == timer.id }) else { return }

        var wasRunning = false
        if let previousActiveTimer = activeTimer, !previousActiveTimer.isPaused {
            // Pause the timer that was previously active and running
            previousActiveTimer.pause()
            wasRunning = true
        }
        
        // Set the new active timer
        activeTimer = timer
        activeTimerIndex = timerIndex
        
        // Only resume if the previous active timer was running and the new active timer has time remaining
        if wasRunning && activeTimer?.timeRemaining ?? 0 > 0 {
            activeTimer?.resume()
        }
    }
    
    /// Checks if the specified timer is the currently active (selected) timer.
    ///
    /// - Parameter timer: The `GTTimer` instance to check.
    /// - Returns: `true` if the specified timer is the active timer, otherwise `false`.
    func isActive(timer: GTTimer) -> Bool {
        return timer.id == activeTimer?.id
    }
    
}
