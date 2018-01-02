//
//  BlueViewController.swift
//  WeatherApp
//
//  Created by Admin on 1/1/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {
    
    @IBAction func celButton(_ sender: UIButton) {
        GlobalStuff.myTempFormat = TempFormat.Celsius
        messageLabel.text = "Celsius Selected"
    }
    @IBAction func farButton(_ sender: UIButton) {
        GlobalStuff.myTempFormat = TempFormat.Fahrenheit
        messageLabel.text = "Fahrenheit Selected"
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toMain"{
            guard let _ = segue.destination as? ViewController else {return}
            
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(true, forKey: "WalkthroughComplete")
//            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func shouldPerformSegue(_ sender: Any) {
        guard GlobalStuff.myZipCodes.count != 0 else {
            messageLabel.text = "Hey buddy, go back and pick out a zip code \n👈"
            return}
        guard let _ = GlobalStuff.myTempFormat else {
            messageLabel.text = "You have not selected a format yet!"
            return}
        self.performSegue(withIdentifier: "toMain", sender: nil)
    }
    

    
}

