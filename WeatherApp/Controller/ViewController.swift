//
//  ViewController.swift
//  WeatherApp
//
//  Created by Admin on 12/31/17.
//  Copyright © 2017 Jamie Chu. All rights reserved.
//

import UIKit
import CoreLocation

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
        return 9*(temp - 273.15)/5 + 32
    }
}


class ViewController: UIViewController   {
    var myCityWeather:CityWeather?
    var myForecastWeek:ForecastWeek?
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var coreLocationText: UILabel!
    @IBAction func updateLocation(_ sender: Any) {
        startUpdatingLocation()
    }
    
    var locationManager: CLLocationManager?
    //lets make this a computed property
    var lastLocation:CLLocation?{
        //convenient updating
        didSet {
            //updating labels
            coreLocationText.text = "Location Lon Lat: \n\(lastLocation?.coordinate.longitude ?? 9001) \(lastLocation?.coordinate.latitude ?? 9001)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("view did load")
        //        view.backgroundColor = .orange
        
        initializeCL()
        print(getTempFormatted(tempFormat: TempFormat.Fahrenheit, temp: 43.22))
        
//        getUserDefaultValues()
//        getForecast()
//        getWeather()
        
    }
    
    func getForecast(){
        let tempNet = Networking()
        
        tempNet.getForcastWeek(by: .zipCode(90210)) { (forecastWeek, error) in
            print("forecast completionHandler")
            guard error == nil else{print(error!.localizedDescription);return}
            guard let _ = forecastWeek else {return}
            //            print(weatherTemp)
            print("forecast Successfully downloaded")
        }
    }
    
    func getUserDefaultValues(){
//        let userDefaults = UserDefaults.standard
        print("displaying user defaults...")
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

private typealias CoreLocationSupport = ViewController
extension CoreLocationSupport: CLLocationManagerDelegate{
    func initializeCL(){
        locationManager = CLLocationManager() //instantiation transferred to app delegate
        locationManager?.delegate = self
//        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
        checkCoreLocationPermission()
        self.startUpdatingLocation()
    }
    
    
    func checkCoreLocationPermission(){
        let authStatus = CLLocationManager.authorizationStatus()
        
        switch authStatus{
        case .authorizedWhenInUse:
            startUpdatingLocation()
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted:
            //TODO: lets add an alert here
            print("sorry, you are unauthorized to use core location")
        default:
            return
        }
    }
    
    func startUpdatingLocation(){
        locationManager?.startUpdatingLocation()
    }

    //stop updating location to conserve battery life
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("updating locations...")
        guard let last = locations.last else{print("can't update"); return}
        lastLocation = last
        print(last.coordinate.longitude)
        print(last.coordinate.latitude)

        locationManager?.stopUpdatingLocation()
    }
    
    
    //helper func from Alfonso's example
    //TODO: implement this into project
    func delay(for seconds:Double,action:@escaping ()->()){
        DispatchQueue.global().asyncAfter(deadline: .now() + seconds, execute: action)
    }
    
    
}


private typealias privateHelperFunctions = ViewController
extension privateHelperFunctions{
    
    //takes in your unixTime:Int and returns a string of current date
    func date_IntToString(forUnixTime time:Int)->String{
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date as Date)
    }

    //takes in the userDefaults preference and a temp and returns temp
    func getTempFormatted(tempFormat:TempFormat, temp:Double)->Double{
        switch tempFormat{
        case .Fahrenheit:
            return TempType.Fahrenheit(temp).Value
        case .Celsius:
            return TempType.Celsius(temp).Value
        }
    }
    
    //takes in a Kelvin value and converts it into a color.
    //convert to celsius first then compare.
    func getBackgroundColor(with temp:Double){

        
        let celTemp = Int(TempType.Celsius(temp).Value)
        
        switch celTemp {
        case let temp where temp < 10:
            UIView.animate(withDuration: 1, animations: {
                self.backgroundColorView.backgroundColor = UIColor.red
            }, completion: nil)
            
//            view.backgroundColor = .blue
        case let temp where temp < 10:
            view.backgroundColor = .blue
            
            
        case let temp where temp < 10:
            view.backgroundColor = .blue

        default:
            return
        }
//        if(temp > 10 && temp <= 19){
//            color='yellow'
//        }else if(temp > 19 && temp <= 29){
//            color='green'
//        }else if(temp > 29){
//            color='red'
//        }
        
    }
}

