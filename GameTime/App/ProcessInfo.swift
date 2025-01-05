//
//  ProcessInfo.swift
//  GameTime
//
//  Created by Jaime Lucea on 4/1/25.
//

import Foundation

extension ProcessInfo {
    var isPreloadingTimers: Bool {
        arguments.contains("--mock-timers")
    }
}
