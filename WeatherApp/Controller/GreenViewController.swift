//
//  GreenViewController.swift
//  WeatherApp
//
//  Created by Admin on 1/1/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var responseLabel: UILabel!
    @IBAction func validateZip(_ sender: Any) {
        
        guard let tempInput = inputText.text else{return}
        guard let temp = Int(tempInput) else {
            responseLabel.text = "Invalid input\n\nPlease try again"
            return
        }
        
        if GlobalStuff.myZipCodes.contains(temp){
            responseLabel.text = "Zip code \(temp) already exists!\n\nPlease try a different one"
        }else if 501...99950 ~= temp {
            GlobalStuff.myZipCodes.append(temp)
            responseLabel.text = "seems... ok 👍\n\(temp) added"
        }else{
            responseLabel.text = "Out of range!\n\nPlease try again"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textLabel?.text = "Please enter in your 5-digit zipcode. "
        inputText.becomeFirstResponder()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

