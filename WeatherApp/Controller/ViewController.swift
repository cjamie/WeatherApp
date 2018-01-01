//
//  ViewController.swift
//  WeatherApp
//
//  Created by Admin on 12/31/17.
//  Copyright © 2017 Jamie Chu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("view did load")
        let tempNet = Networking()
        tempNet.getWeather(by: .zipCode(94040)) { (cityWeather, error) in
            print("completionhandler")
            guard error == nil else{print(error?.localizedDescription);return}
            
            guard let weatherTemp = cityWeather else {return}
            print(weatherTemp)
        }
        
//        http://samples.openweathermap.org/data/2.5/weather?zip=94040,us&appid=b6907d289e10d714a6e88b30761fae22
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

