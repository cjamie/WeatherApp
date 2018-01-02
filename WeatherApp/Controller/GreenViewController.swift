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
            responseLabel.text = "Invalid input"
            return
        }
        if 501...99950 ~= temp {
            GlobalStuff.myZipCodes.append(temp)
            responseLabel.text = "seems... ok 👍"
        }else{
            responseLabel.text = "Out of range!"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textLabel?.text = "Please enter in your 5-digit zipcode. "
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
//
//  GreenViewController.swift
//  WeatherApp
//
//  Created by Admin on 1/1/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation
