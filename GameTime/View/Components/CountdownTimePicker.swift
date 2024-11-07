//
//  CountdownTimePicker.swift
//  GameTime
//
//  Created by Jaime Lucea on 7/11/24.
//

import SwiftUI

public struct CountdownTimePicker: View {
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    private let hourRange = Array(0...23)
    private let minuteAndSecondRange = Array(0...59)
    
    public var body: some View {
        HStack(spacing: 10) {
            Picker(selection: $hours, label: Text("Hours")) {
                ForEach(hourRange, id: \.self) { hour in
                    Text("\(hour) h").tag(hour)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: 80) // Adjust width to fit your design
            
            Picker(selection: $minutes, label: Text("Minutes")) {
                ForEach(minuteAndSecondRange, id: \.self) { minute in
                    Text("\(minute) m").tag(minute)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: 80)
            
            Picker(selection: $seconds, label: Text("Seconds")) {
                ForEach(minuteAndSecondRange, id: \.self) { second in
                    Text("\(second) s").tag(second)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: 80)
        }
    }
}
