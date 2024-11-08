//
//  NewTimerScreen.swift
//  GameTime
//
//  Created by Jaime Lucea on 20/10/22.
//

import SwiftUI

struct CreateTimerView: View {
    
    @StateObject private var viewModel: ViewModel
    
    @State private var showColorPicker: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    init(isPresented: Binding<Bool>, _ manager: GTTimerManager? = nil) {
        self._viewModel = StateObject(wrappedValue: ViewModel(isPresented: isPresented, manager))
    }
    
    var body: some View {
        NavigationView {
            VStack (spacing: 6) {
                CountdownTimePicker(hours: $viewModel.time[0], minutes: $viewModel.time[1], seconds: $viewModel.time[2])
                
                Form {
                    HStack {
                        Text("Name")
                            .frame(minWidth: 0, idealWidth: .infinity, alignment: .leading)
                        TextField("Name", text: $viewModel.name)
                            .multilineTextAlignment(.trailing)
                            .autocorrectionDisabled()
                            .submitLabel(.done)
                    }
                    HStack {
                        Text("Color")
                        Spacer()
                        Circle()
                            .foregroundStyle(viewModel.color)
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                showColorPicker = true
                            }
                    }
                }
            }
            .navigationTitle("Timer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.saveAndClose()
                    }
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $showColorPicker) {
                ColorPickerView(selectedColor: $viewModel.color) {
                    showColorPicker = false
                }
                .padding(.top, 18)
            }
        }
    }
    
}
    
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

#Preview {
    CreateTimerView(isPresented: Binding.constant(true))
}
