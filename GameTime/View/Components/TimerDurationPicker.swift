
import SwiftUI

public struct TimerDurationPicker: View {
    
    @Binding var duration: TimerDuration
    
    private let hourRange = Array(0...23)
    private let minuteAndSecondRange = Array(0...59)
    
    public var body: some View {
        HStack(spacing: 10) {
            Picker(selection: $duration.hours, label: Text("Hours")) {
                ForEach(hourRange, id: \.self) { hour in
                    Text("\(hour) h").tag(hour)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: 80)
            
            Picker(selection: $duration.minutes, label: Text("Minutes")) {
                ForEach(minuteAndSecondRange, id: \.self) { minute in
                    Text("\(minute) m").tag(minute)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: 80)
            
            Picker(selection: $duration.seconds, label: Text("Seconds")) {
                ForEach(minuteAndSecondRange, id: \.self) { second in
                    Text("\(second) s").tag(second)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: 80)
        }
    }
}

#Preview {
    TimerDurationPicker(duration: Binding.constant(.init(hours: 0, minutes: 25, seconds: 30)))
}
