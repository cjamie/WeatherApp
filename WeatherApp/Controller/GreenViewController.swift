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
    
    let userDefaults = UserDefaults.standard
    
    @IBAction func validateZip(_ sender: Any) {
        inputText.resignFirstResponder()
        
        guard let tempInput = inputText.text else{return}
        guard let temp = Int(tempInput) else {
            responseLabel.text = "Invalid input\n\nPlease try again"
            return
        }
        
        if 501...99950 ~= temp {
            responseLabel.text = (userDefaults.object(forKey: "userZip") != nil) ? "default zipcode changed to \(temp)" : "seems... ok 👍\n\(temp) added"
                userDefaults.set(temp, forKey: "userZip") //assign an int to userZip
        }else{
            responseLabel.text = "Out of range!\n\nPlease try again"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
    }
    
    func initalize(){
        print("green VDL")
        self.textLabel?.text = "Please enter in your 5-digit zipcode. "
        if userDefaults.object(forKey: "userZip") != nil {
            let temp = userDefaults.integer(forKey: "userZip")
            responseLabel.text = "Your default zip code is currently \(temp)"
        }
        self.inputText.delegate = self
    }
        
}
typealias FirstResponderFunctions = GreenViewController
extension FirstResponderFunctions: UITextFieldDelegate{
    
    //for when i touch outside of the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
