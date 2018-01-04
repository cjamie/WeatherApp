//
//  GlobalConstants.swift
//  WeatherApp
//
//  Created by Admin on 12/31/17.
//  Copyright © 2017 Jamie Chu. All rights reserved.
//

import Foundation

//should have rawValue is still itself. they are stored into userDefaults as a preference parameter
enum TempFormat:String{
    case Celsius
    case Fahrenheit
}

//for now, it is my Core Data simulator

class GlobalStuff{
//    static let bearer = "b6907d289e10d714a6e88b30761fae22"
    static let bearer = "58b8d82a14720df41a9274b188d1e110"
//    static var CityWeatherCache = [WeatherMethod:CityWeather]() //might not need to cache in this assignment... also, cityweather is not hashable so need NSDictionary
//    static var myZipCodes = [Int]()
    static var myTempFormat:TempFormat?
    
    //TODO: dictionary for additional zipcodes
    
    
}



