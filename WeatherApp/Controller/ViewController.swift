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
        getForecast()
        //        getWeather()
        
    }
    
    
    func getForecast(){
        let tempNet = Networking()

//        tempNet.getForcastWeek(by: .cityId(2172797)) { (forecastWeek, error) in
//            print("forecast 1")
//            guard error == nil else{print(error!.localizedDescription);return}
//            guard let weatherTemp = forecastWeek else {return}
//            print(weatherTemp)
//        }
//
//        tempNet.getForcastWeek(by: .cityName("Boston")) { (forecastWeek, error) in
//            print("forecast 2")
//            guard error == nil else{print(error!.localizedDescription);return}
//            guard let weatherTemp = forecastWeek else {return}
//            print(weatherTemp)
//        }
//
//        tempNet.getForcastWeek(by: .geographicCooridinates(2.5, 32.1)) { (forecastWeek, error) in
//            print("forecast 3")
//            guard error == nil else{print(error!.localizedDescription);return}
//            guard let weatherTemp = forecastWeek else {return}
//            print(weatherTemp)
//        }
        
        tempNet.getForcastWeek(by: .zipCode(90210)) { (forecastWeek, error) in
            print("forecast 4")
            guard error == nil else{print(error!.localizedDescription);return}
            guard let weatherTemp = forecastWeek else {return}
            print(weatherTemp)
        }
        
        
    }
    
    
    
    
    //unclogs my viewDidLoad for now
    func getWeather(){
        let tempNet = Networking()
        
        tempNet.getWeather(by: .cityId(2172797)) { (cityWeather, error) in
            guard error == nil else{print(error!.localizedDescription);return}            
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
    
}

