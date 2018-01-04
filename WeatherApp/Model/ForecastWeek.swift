//
//  ForecastWeek.swift
//  WeatherApp
//
//  Created by Admin on 1/1/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

struct ForecastWeek:Codable{//not Codable
    //enum ForecastDay{
    //    case ByInt(ForecastDayByInt)
    //    case ByCity(ForecastDayByCity)
    //    case ByLonLat(ForecastDayByLonLat)
    //    case ById(ForcaseDayById)
    //}
    
    var cod:String
    var message:Double
    var city:City
    var cnt:Int
    var list:[ForecastDayByZip]
}

//can't make forecastDay conform to Codable so need to manually parse json

struct ForecastDayById:Codable{
    var dt: Int
    var temp:Temp?
    var pressure:Double?
    var humidity:Int
    var weather:[ForecastWeather]
    var speed:Double
    var deg:Int
    var clouds:Int//this can be an int or a Clouds.... in other type
    var snow:Double? //some days don't have snow
}


struct ForecastDayByName: Codable{
    var dt:Int
    var main: Main
    var weather:[ForecastWeather]
    var clouds:Clouds
    var wind:Wind
//    var rain: Rain?
    var sys:Sys
    var dt_txt:String
}

struct ForecastDayByLonLat{
    var dt:Int
    var main:Main
    var weather:[ForecastWeather]
    var clouds: Clouds
    var wind:Wind
    var rain:Rain?
    var sys:Sys
    var dt_txt: String
}

struct ForecastDayByZip:Codable{
    var dt:Int
    var main:Main?
    var weather:[ForecastWeather]
    var clouds:Clouds?
    var wind:Wind?
    var rain:Rain?
    var sys:Sys?
    var dt_txt:String//done
}

struct Rain:Codable{ //how does this work with codable?
    var rain3h:Double?
    init?(json: [String: Double]) {
        guard let my3h = json["3h"] else {print("Serialization Error- Rain");return nil}
        self.rain3h = my3h
    }
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
    var id: Int? //does not exist for zip
    var geoname_id:Int?
    var name:String
    var lat:Double?
    var lon:Double?
    var coord: Coord?
    var country:String
    var iso2:String?
    var type:String?
    var population:Int? //does not exist for zipcode
}
