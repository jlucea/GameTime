//
//  PlayerAddViewController.swift
//  GameTime
//
//  Created by Jaime Lucea on 26/8/22.
//

import UIKit

//class PlayerAddViewController: UIViewController, UITextFieldDelegate {
//
//    @IBOutlet weak var playerNameTextField: UITextField!
//
//    var playerHandler : PlayerManagingDelegate?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        playerNameTextField.delegate = self
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print(playerNameTextField.text!)
//        return true
//    }
//
//    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
//        print("Cancel button pressed")
//        self.dismiss(animated: true)
//    }
//
//    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
//        print("Save button pressed")
//        playerHandler?.addPlayer(playerName: playerNameTextField.text!)
//        self.dismiss(animated: true)
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "returntoSetup" {
//            let setupVC = segue.destination as! SetupViewController
//            setupVC.addPlayer(playerName: playerNameTextField.text!)
//        }
//    }
//     */
//
//}
//
//
//protocol PlayerManagingDelegate {
//
//    func addPlayer(playerName: String)
//
//}
