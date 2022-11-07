//
//  NewTimerScreen.swift
//  GameTime
//
//  Created by Jaime Lucea on 20/10/22.
//

import SwiftUI

struct NewTimerScreen: View {
    
    @EnvironmentObject var timerController : StateController
    
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
    
    @FocusState private var textFieldFocus: Bool

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
                        
                        TimerNameInputView(playerName: $playerName)
                        
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
        let newTimer = PlayerTimer(name: playerName, color: selectedColor, maxTime: totalSecondsSelected)
        timerController.addTimer(timer: newTimer)
        
        // Dismiss view
        dismiss()
    }
    
}


/*
 * This is a view containing only a TextField
 */
struct TimerNameInputView : View {

    @Binding var playerName : String
    @FocusState private var textFieldFocus: Bool

    // Used to dismiss the view
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {

        VStack {
            TextField("", text: $playerName)
                .autocorrectionDisabled()
                .submitLabel(.done)
                .onSubmit {
                    dismiss()
                }
                .padding()
                .background(Color(UIColor.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .focused($textFieldFocus)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        self.textFieldFocus = true
                    }
                }
        }
        .padding(.horizontal)
        .navigationTitle("Name")
    }

}


struct NewTimerScreen_Previews: PreviewProvider {
    
    struct PreviewContainer : View {
                
        var body: some View {
            NewTimerScreen()
        }
    }
    
    static var previews: some View {
        PreviewContainer()
    }
}
