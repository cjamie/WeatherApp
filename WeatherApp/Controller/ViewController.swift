//
//  ViewController.swift
//  WeatherApp
//
//  Created by Admin on 12/31/17.
//  Copyright © 2017 Jamie Chu. All rights reserved.
//

import UIKit

enum TempType{
    case Celsius(Double)
    case Fahrenheit(Double)
    
    var Value: Double{
        switch self{
        case .Celsius(let input):
            return KelToCel(forKel: input)
        case .Fahrenheit(let input):
            return KelToFar(forKel: input)
        }
    }
}

extension TempType{
    func KelToCel(forKel temp:Double)->Double{
        return temp-273.15
    }
    func KelToFar(forKel temp:Double)->Double{
        return 9/5*(temp - 273.15) + 32
    }
}



class ViewController: UIViewController {
    var myCityWeather:CityWeather?
    var myForecastWeek:ForecastWeek?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("view did load")
//        view.backgroundColor = .orange

        getUserDefaultValues()
        getForecast()
        getWeather()

    }
    func displayPageViews(completion: @escaping()->()){
        let userDefaults = UserDefaults.standard
        let condition = userDefaults.bool(forKey: "WalkthroughComplete")
        print(condition)
        if !condition{
            if let NewPageView = storyboard?.instantiateViewController(withIdentifier: "NewPageView"){
                print("presenting page views?")
                present(NewPageView, animated: true, completion: nil)
            }else{
                print("couldNotPass")
            }
        }
    }
    
    func getForecast(){
        let tempNet = Networking()
        
        tempNet.getForcastWeek(by: .zipCode(90210)) { (forecastWeek, error) in
            print("forecast completionHandler")
            guard error == nil else{print(error!.localizedDescription);return}
            guard let weatherTemp = forecastWeek else {return}
//            print(weatherTemp)
            print("forecast Successfully downloaded")
        }
    }
    
    func getUserDefaultValues(){
        let userDefaults = UserDefaults.standard
        print("printing user defaults")
        print(userDefaults.bool(forKey: "WalkthroughComplete"))
        print(userDefaults.integer(forKey: "userZip"))

        print(userDefaults.object(forKey: "CelsiusOrFarenheit")!)
    }
    
    
    func getWeather(){
        let tempNet = Networking()
        
        tempNet.getWeather(by: .cityId(2172797)) { (cityWeather, error) in
            guard error == nil else{print(error!.localizedDescription);return}            
            guard let _ = cityWeather else {return}
            print("cityWeather Successfully downloaded")
        }
        
        //        tempNet.getWeather(by: .geographicCooridinates(3.2, 55.2)) { (cityWeather, error) in
        //            guard error == nil else{print(error!.localizedDescription);return}
        //
        //            guard let weatherTemp = cityWeather else {return}
        //            print(weatherTemp)
        //        }
        
    }
    
}


