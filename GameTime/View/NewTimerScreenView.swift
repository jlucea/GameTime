//
//  NewTimerScreen.swift
//  GameTime
//
//  Created by Jaime Lucea on 20/10/22.
//

import SwiftUI

struct NewTimerScreen: View {
    
    @EnvironmentObject var timerController : StateController
    
    @State private var playerName : String = ""
    
    // Since there is no TimeIntervalPicker as of SwiftUI
    // we're using a customizable PickerView
    private let data: [[String]] = [
        Array(0...10).map { "\($0) h" },
        Array(0...59).map { "\($0) min" }
    ]

    @State var selections: [Int] = [0, 30]
    
    @State var selectedColor : Color = Color.green
    @Binding var isPresented : Bool
    
    let frameWidth : CGFloat = 350
    let frameHeight : CGFloat = 400
    
    private let button_size = CGFloat(66)
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Player name", text: $playerName)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 250, alignment: .center)
                        .padding(.leading)
                    
                    ColorPicker("", selection: $selectedColor, supportsOpacity: false)
                        .padding(.trailing)
                }
                .padding([.leading, .trailing])

                PickerView(data: self.data, selections: self.$selections)
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
                        isPresented.toggle()
                    })
                }
            }
        }
        .frame(idealWidth: frameWidth, maxWidth: frameWidth, idealHeight: frameHeight, maxHeight: frameHeight)
        // .border(.green, width: 2)
        .navigationViewStyle(.stack)
    }
    
    func saveAndClose() {
        
        print("New timer - save button pressed")
        print("New timer name: \(playerName)")
        
        let totalSecondsSelected = 60 * 60 * selections[0] + 60 * selections[1]

        print("Selections: \(self.selections[0]) \(self.selections[1])")
        print("Selected data: \(self.data[0][self.selections[0]]) \(self.data[1][self.selections[1]])")
        print("Seconds selected: \(totalSecondsSelected)")
        
        // Instantiate and add new timer
        let newTimer = PlayerTimer(name: playerName, color: selectedColor, maxTime: totalSecondsSelected)
        timerController.addTimer(timer: newTimer)
        
        // Dismiss view
        isPresented = false
    }
    
}

struct NewTimerScreen_Previews: PreviewProvider {
    
    struct PreviewContainer : View {
        
        @State private var doDisplay : Bool = true
        
        var body: some View {
            NewTimerScreen(isPresented: $doDisplay)
        }
    }
    
    static var previews: some View {
        PreviewContainer()
    }
}
