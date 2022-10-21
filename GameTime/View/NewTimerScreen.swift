//
//  NewTimerScreen.swift
//  GameTime
//
//  Created by Jaime Lucea on 20/10/22.
//

import SwiftUI

struct NewTimerScreen: View {
    
    @State var timeInterval = TimeInterval()
    
    var body: some View {
        
        VStack {
            Text("Enter the new player name")
                .padding()
            
            TimeDurationPicker(duration: $timeInterval)
        }
    }
}

struct NewTimerScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewTimerScreen()
    }
}
