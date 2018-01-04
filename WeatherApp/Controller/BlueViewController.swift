//
//  BlueViewController.swift
//  WeatherApp
//
//  Created by Admin on 1/1/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {
    let userDefaults = UserDefaults.standard

    @IBAction func celButton(_ sender: UIButton) {
        
        userDefaults.set(TempFormat.Celsius.rawValue, forKey: "CelsiusOrFarenheit")
        messageLabel.text = "Celsius Selected"
    }
    @IBAction func farButton(_ sender: UIButton) {
        userDefaults.set(TempFormat.Fahrenheit.rawValue, forKey: "CelsiusOrFarenheit")
        messageLabel.text = "Fahrenheit Selected"
    }
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.setValue(false, forKey: "WalkthroughComplete")

    }
    
    //should rename this because it instantiates now rather than segue
    @IBAction func shouldPerformSegue(_ sender: Any) {
        guard userDefaults.object(forKey: "userZip") != nil else{
            messageLabel.text = "Hey buddy, go back and pick out a zip code \n👈"
            return
        }
        userDefaults.setValue(true, forKey: "WalkthroughComplete")
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherController") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
}

