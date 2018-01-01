//
//  WeatherCall.swift
//  WeatherApp
//
//  Created by Admin on 12/31/17.
//  Copyright © 2017 Jamie Chu. All rights reserved.
//

import Foundation

//enum StructType{
//    case multipleCityWeather(MultipleCityWeather)
//    case cityWeather(CityWeather)
//    case coord(Coord)
//    case weather(Weather)
//    case main(Main)
//    case wind(Wind)
//    case clouds(Clouds)
//    case sys(Sys)
//}

struct MultipleCityWeather:Codable{
    var cod:String
    var calctime:Double
    var cnt:Int
    var list: [CityWeather]
}

struct CityWeather: Codable{ //
    var coord: Coord
    var weather:[Weather]
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var dt: Int//maybe this is a Long
    var clouds: Clouds
    var sys: Sys
    var id: Int
    var name: String
    var cod: Int
}

struct Coord: Codable{
    var lon: Double
    var lat: Double
}

struct Weather: Codable{
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable{
    var temp: Double
    var pressure: Int
    var humidity: Int
    var temp_min: Double
    var temp_max: Double
}


struct Wind: Codable{
    var speed: Double
    var deg: Double
}

struct Clouds: Codable{
    var all: Int
}

struct Sys: Codable{
    var type:Int
    var id:Int
    var message:Double
    var country:String
    var sunrise: Int
    var sunset: Int
}
