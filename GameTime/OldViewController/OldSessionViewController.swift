//
//  ViewController.swift
//  GameClock
//
//  Created by Jaime Lucea on 1/8/22.
//

import UIKit

//class SessionViewController: UIViewController, ClockListener {
//    
//    @IBOutlet weak var playerNameLabel: UILabel!
//    @IBOutlet weak var timerLabel: UILabel!
//    @IBOutlet weak var pauseButton: UIButton!
//    @IBOutlet weak var progressBar: UIProgressView!
//        
//    var time: TimeInterval?
//    var playerNames : [String]?
//    
//    private var clocks: [PlayerClock]? = []
//    private var activePlayer = 0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Instantiate clocks
//        for playerName in playerNames! {
//            let newClock = PlayerClock(name: playerName, color: UIColor.yellow, maxTime: Int(time!), listener: nil)
//            clocks?.append(newClock)
//            newClock.setListener(self)
//        }
//        
//        playerNameLabel.text = playerNames![0]
//        clocks?[0].start()
//    }
//
//    
//    func onClockTick(clock: PlayerClock) {
//        timerLabel.text = clock.getTimeString()
//        progressBar.progress = clock.getProgress()
//    }
//    
//    @IBAction func pauseButtonPressed(_ sender: Any) {
//        
//        if let playerClock = clocks?[activePlayer] {
//            
//            if (playerClock.isPaused) {
//                playerClock.resume()
//                pauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
//            } else {
//                playerClock.pause()
//                pauseButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
//            }
//        }
//    }
//    
//    @IBAction func nextButtonPressed(_ sender: Any) {
//        // Pause current clock
//        clocks?[activePlayer].pause()
//        
//        // Increase player index
//        if activePlayer == playerNames!.count - 1 {
//            activePlayer = 0
//        }else{
//            activePlayer += 1
//        }
//        
//        // Get next clock
//        let nextClock = clocks![activePlayer]
//        
//        // Update label
//        playerNameLabel.text = playerNames![activePlayer]
//        timerLabel.text = nextClock.getTimeString()
//        progressBar.progress = nextClock.getProgress()
//        
//        // Start next clock
//        nextClock.start()
//        pauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
//    }
//    
//}

