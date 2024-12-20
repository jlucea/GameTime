//
//  GameTimeToolbar.swift
//  GameTime
//
//  Created by Jaime Lucea on 20/12/24.
//

import SwiftUI

struct GameTimeToolbar {
        
    private static let toolbarTitle = "GameTime"
    
    static func content(showAddNewTimerScreen: Binding<Bool>, controller: GTTimerManager) -> some ToolbarContent {
        Group {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    showAddNewTimerScreen.wrappedValue = true
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                })
                .padding(.bottom, 6)
                .popover(isPresented: showAddNewTimerScreen, content: {
                    CreateTimerView(isPresented: showAddNewTimerScreen, controller)
                } )
            }
            ToolbarItem(placement: .principal) {
                Text(toolbarTitle).font(.headline)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                if !controller.timers.isEmpty {
                    // Pressing this button will activate editMode
                    EditButton()
                }
            }
        }
    }
    
}

#Preview {
    
//    GameTimeToolbar(showAddNewTimerScreen: Binding.constant(false))
//        .environmentObject(GTTimerManager())
}
