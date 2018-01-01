//
//  Networking.swift
//  WeatherApp
//
//  Created by Admin on 12/31/17.
//  Copyright © 2017 Jamie Chu. All rights reserved.
//

import UIKit
import Alamofire
//    var a = "http://samples.openweathermap.org/data/2.5/weather?zip=94040,us&appid=b6907d289e10d714a6e88b30761fae22"

// MARK: protocol extensions, enum's application in networking
/*
 Enums have amazing utility for separation of concerns.
 */

protocol NetworkProtocol {
    //    func getImage(byName url:String, withType type:StructType, completion: @escaping(UIImage?, Error?) -> ())
    
    func getWeather(by type:WeatherMethod, completion: @escaping(CityWeather?, Error?)->())
}

enum WeatherMethod{
    case cityName(String) //{cityName, countryCode}
    case cityId(Int)    //{cityID}
    case geographicCooridinates(Int, Int) //{lat&lon}
    case zipCode(Int) //{zipCode&countryCode}
}

enum NetworkingError:Error{
    case noResponse
    case responseError(Int) //HTTP response codes
    case noData
    case couldNotParseData //TODO: add extra for implementation for invalid json/invalid codable struct
}


class Networking{
    
}

//TODO: change Networking into an enum for .getJson, .post examples
typealias NetworkingFunction = Networking
extension NetworkingFunction: NetworkProtocol{
    
    func getWeather(by type: WeatherMethod, completion: @escaping (CityWeather?, Error?) -> ()) {
        var myUrl = String()
        
        
        switch type{
            
        case .cityId(let myId):
            //forecast is different from weather. 
            myUrl = "http://samples.openweathermap.org/data/2.5/weather?q=\(myId),DE&appid=\(GlobalConstants.bearer)"
        case .cityName(let myName):
            myUrl = "http://samples.openweathermap.org/data/2.5/weather?q=\(myName)&appid=\(GlobalConstants.bearer)"
        case .geographicCooridinates(let lat, let lon):
            myUrl = "http://samples.openweathermap.org/data/2.5/weather?lat=\(lat))&lon=\(lon)&appid=\(GlobalConstants.bearer)"
        case .zipCode(let myZipCode):
            myUrl = "http://samples.openweathermap.org/data/2.5/weather?zip=\(myZipCode),us&appid=\(GlobalConstants.bearer)"
        }
        
        guard let uurl = URL(string:myUrl) else {return}
        Alamofire.request(uurl).response { (dataResponse) in
            guard dataResponse.error == nil else {  //error
                guard let resp = dataResponse.response else {
                    //no response.
                    completion(nil, NetworkingError.noResponse)
                    return
                }
                //there is error but still has a response code
                completion(nil, NetworkingError.responseError(resp.statusCode))
                return
            }
            
            guard let data = dataResponse.data else {
                //no data
                completion(nil, NetworkingError.noData)
                return
            }
            
            do{
                let temp = try JSONDecoder().decode(CityWeather.self, from: data)
                completion(temp,nil)
            }catch let error{
                print("Serialziation Error")
                completion(nil, error)
            }
        }
    }
    
    
}

