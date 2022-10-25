//
//  MainViewController.swift
//  GameTime
//
//  Created by Jaime Lucea on 15/10/22.
//

import UIKit

class OldMainViewController : UIViewController {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var timersStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTimerPressed(_ sender: Any) {
        
        print("Add timer button pressed")
    }
    
    
    
}
