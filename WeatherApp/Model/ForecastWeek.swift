//
//  ForecastWeek.swift
//  WeatherApp
//
//  Created by Admin on 1/1/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

struct ForecastWeek:Codable{
    var cod:String
    var message:Int
    var city:City
    var cnt:Int
    var list:[ForecastDay]
}

struct ForecastDay:Codable{
    var dt: Int
    var temp:Temp
    var pressure:Double
    var humidity:Int
    var weather:[ForecastWeather]
    var speed:Double
    var deg:Int
    var clouds:Int
    var snow:Double
}

struct Temp:Codable{
    var day:Double
    var min:Double
    var max:Double
    var night:Double
    var eve:Double
    var morn:Double
}

struct ForecastWeather:Codable{
    var id:Int
    var main:String
    var description:String
    var icon:String
}

struct City:Codable{
    var geoname_id:Int
    var name:String
    var lat:Double
    var lon:Double
    var country:String
    var iso2:String
    var type:String
    var population:Int
}
