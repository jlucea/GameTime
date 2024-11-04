//
//  NewTimerScreen.swift
//  GameTime
//
//  Created by Jaime Lucea on 20/10/22.
//

import SwiftUI

struct NewTimerView: View {
    
    @EnvironmentObject var timerController : GTTimerManager
    
    @State private var playerName : String = "Player"
    
    // Since there is no TimeIntervalPicker as of SwiftUI
    // we're using a customizable PickerView
    private let timePickerValues: [[String]] = [
        Array(0...10).map { "\($0) h" },
        Array(0...59).map { "\($0) min" }
    ]

    // Values that are selected in the time picker
    @State var selectedTimePickerValues: [Int] = [0, 30]
        
    // TODO: Make initial color value random or based on the number of existing timers?
    @State var selectedColor : Color = Color.green
    
    let frameWidth : CGFloat = 350
    let frameHeight : CGFloat = 400
    
    // Used to dismiss the view
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                // Time picker
                PickerView(data: self.timePickerValues, selections: self.$selectedTimePickerValues)
                    .frame(width: frameWidth, height: 160)
                    .padding(.top)
                
                Form {
                    NavigationLink  {
                        
                        TimerNameInputView(text: $playerName)
                        
                    } label: {
                        // Display the name of the timer in the form's navigation link
                        HStack {
                            Text("Name").frame(maxWidth:.infinity, alignment: .leading)
                            Text($playerName.wrappedValue)
                                .lineLimit(1)
                                .foregroundColor(Color(UIColor.lightGray))
                                .frame(maxWidth: 260, alignment: .trailing)
                        }
                    }
                    
                    // Using the system's ColorPicker without opacity controls
                    ColorPicker("Color", selection: $selectedColor, supportsOpacity: false)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add Player").font(.headline)
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Save", action: {
                        saveAndClose()
                    })
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: {
                        dismiss()
                    })
                }
            }
        }
        .frame(idealWidth: frameWidth, maxWidth: frameWidth, idealHeight: frameHeight, maxHeight: frameHeight)
        .navigationViewStyle(.stack)
    }
    
    func saveAndClose() {
        
        print("New timer - save button pressed")
        print("New timer name: \(playerName)")
        
        let totalSecondsSelected = 60 * 60 * selectedTimePickerValues[0] + 60 * selectedTimePickerValues[1]

//        print("Selections: \(self.selections[0]) \(self.selections[1])")
//        print("Selected data: \(self.timePickerValues[0][self.selections[0]]) \(self.timePickerValues[1][self.selections[1]])")
//        print("Seconds selected: \(totalSecondsSelected)")
        
        // Instantiate and add new timer
        let newTimer = GTTimer(name: playerName, color: selectedColor, maxTime: totalSecondsSelected)
        timerController.addTimer(timer: newTimer)
        
        // Dismiss view
        dismiss()
    }
    
}


struct NewTimerScreen_Previews: PreviewProvider {
    
    struct PreviewContainer : View {
                
        var body: some View {
            NewTimerView()
        }
    }
    
    static var previews: some View {
        PreviewContainer()
    }
}
