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
        setBackgroundColor(with: 70)
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
        
//        initializeCL()
//        print(getTempFormatted(tempFormat: TempFormat.Fahrenheit, kelvinTemp: 43.22))
        
//        getUserDefaultValues()
        getForecast()
        //        getWeather()
        
    }
    
    func getForecast(){
        let tempNet = Networking()
        
//        tempNet.getForcastWeek(by: .zipCode(90210)) { (forecastWeek, error) in

        tempNet.getForcastWeek(by: .geographicCooridinates(lat: 37.78, lon: -122.4)) {
            (forecastWeek, error) in
            print("forecast completionHandler")
            guard error == nil else{print(error!.localizedDescription);return}
            guard let forecastTemp = forecastWeek else {return}
            print(forecastTemp)
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
        
        tempNet.getWeather(by: .cityId(id:2172797)) { (cityWeather, error) in
            guard error == nil else{print(error!.localizedDescription);return}            
            guard let _ = cityWeather else {return}
            print("cityWeather Successfully downloaded")
        }
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
    
    //takes in the userDefaults preference and a kelvinTemp:Double and returns temp
    func getTempFormatted(tempFormat:TempFormat, kelvinTemp:Double)->Double{

        switch tempFormat{
        case .Fahrenheit:
            return TempType.Fahrenheit(kelvinTemp).Value
        case .Celsius:
            return TempType.Celsius(kelvinTemp).Value
        }
        
    }
    
    //takes in a Kelvin value and converts it into a color.
    //convert to celsius first then compare.
    func setBackgroundColor(with temp:Double){
        
        
        let celTemp = Int(TempType.Celsius(temp).Value)
        
        if celTemp < 0{
            UIView.animate(withDuration: 1, animations: {
                self.backgroundColorView.backgroundColor = #colorLiteral(red: 0.2107448204, green: 0.6527481474, blue: 1, alpha: 1)
            }, completion: nil)
        }else if (celTemp < 25){
            UIView.animate(withDuration: 1, animations: {
                self.backgroundColorView.backgroundColor = #colorLiteral(red: 0.2529776096, green: 0.9900103211, blue: 1, alpha: 1)
            }, completion: nil)

        }else if (celTemp < 50){
            UIView.animate(withDuration: 1, animations: {
                self.backgroundColorView.backgroundColor = #colorLiteral(red: 0.8077227024, green: 1, blue: 0.3316666253, alpha: 1)
            }, completion: nil)
            
        }else if (celTemp < 75){
            UIView.animate(withDuration: 1, animations: {
                self.backgroundColorView.backgroundColor = #colorLiteral(red: 0.9884319793, green: 1, blue: 0.1975241086, alpha: 1)
            }, completion: nil)
            
        }else if (celTemp < 100){
            UIView.animate(withDuration: 1, animations: {
                self.backgroundColorView.backgroundColor = #colorLiteral(red: 1, green: 0.5112759825, blue: 0.2702919145, alpha: 1)
            }, completion: nil)

        }else{
            UIView.animate(withDuration: 1, animations: {
                self.backgroundColorView.backgroundColor = #colorLiteral(red: 1, green: 0.06543179506, blue: 0, alpha: 1) //UIColor(red: 1, green: 0.06543179506, blue: 0, alpha: 1)
            }, completion: nil)
            
        }
    }
}

