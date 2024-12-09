//
//  GameTimeApp.swift
//  GameTime
//
//  Created by Jaime Lucea on 15/10/22.
//

import SwiftUI

@main
struct GameTimeApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.dark)
                .tint(.white)
        }
    }
}
