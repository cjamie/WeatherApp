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
            guard error == nil else{print(error?.localizedDescription);return}
            
            guard let weatherTemp = cityWeather else {return}
            print(weatherTemp)
        }

//        tempNet.getWeather(by: .geographicCooridinates(3.2, 55.2)) { (cityWeather, error) in
//            guard error == nil else{print(error!.localizedDescription);return}
//
//            guard let weatherTemp = cityWeather else {return}
//            print(weatherTemp)
//        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

