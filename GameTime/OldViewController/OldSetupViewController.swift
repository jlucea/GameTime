//
//  SetupViewController.swift
//  GameTime
//
//  Created by Jaime Lucea on 19/8/22.
//

import UIKit

//
//class SetupViewController: UIViewController, PlayerManagingDelegate {
//    
//    @IBOutlet weak var timePicker: UIDatePicker!
//    @IBOutlet weak var startButton: UIButton!
//    @IBOutlet weak var playerTable: UITableView!
//    
//    var playerArray : [String]? = []
//    
//    override func viewDidLoad() {
//        print("SetupViewController did load")
//        super.viewDidLoad()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        print("View did appear")
//    }
//    
//    @IBAction func addPlayerPressed(_ sender: Any) {
//        print("Add player pressed")
//        
//        self.performSegue(withIdentifier: "addPlayerSegue", sender: self)
//    }
//    
//    @IBAction func startButtonPressed(_ sender: Any) {
//        
//        print("Start button pressed")
//        // print("Player: " + playerNameLabel.text!)
//        print("Time: " + timePicker.countDownDuration.description)
//        
//        self.performSegue(withIdentifier: "beginSessionSegue", sender: self)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "beginSessionSegue" {
//            let clockVC = segue.destination as! SessionViewController
//            clockVC.playerNames = playerArray
//            clockVC.time = timePicker.countDownDuration
//            
//        } else if segue.identifier == "addPlayerSegue" {
//            let addPlayerVC = segue.destination as! PlayerAddViewController
//            addPlayerVC.playerHandler = self
//        }
//    }
//    
//    
//    func addPlayer(playerName: String){
//        print("Adding player")
//        playerArray?.append(playerName)
//        playerTable.reloadData()
//    }
//    
//    
//}
//
//class PlayerCell : UITableViewCell {
//    
//    @IBOutlet weak var playerNameLabel: UILabel!
//    
//}
//
//extension SetupViewController : UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        // print("Table view data source providing number of rows")
//        return playerArray!.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        // print("Table view data source providing cell w indexPath \(indexPath.row)")
//        
//        let cell = self.playerTable.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
//        
//        cell.playerNameLabel.text = playerArray![indexPath.row]
//        
//        return cell
//    }
//        
//}
