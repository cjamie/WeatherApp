//
//  Networking.swift
//  WeatherApp
//
//  Created by Admin on 12/31/17.
//  Copyright © 2017 Jamie Chu. All rights reserved.
//

import UIKit
import Alamofire

//TODO: implement for getForcast with enums
protocol NetworkProtocol {    
    func getWeather(by type:QueryType, completion: @escaping(CityWeather?, Error?)->())
    func getForcastWeek(by type: QueryType, completion: @escaping (ForecastWeek?, Error?) -> ())
}

//associated type enums
enum QueryType{
    case cityName(String) //{cityName, countryCode}
    case cityId(Int)    //{cityID}
    case geographicCooridinates(Double, Double) //{lat&lon}
    case zipCode(Int) //{zipCode&countryCode}
}

//TODO: use this for returning instead of having 2 separate return functions and return types.
enum WeatherReturn{
    case weather(CityWeather)
    case forecast(ForecastWeek)
}

enum NetworkingError:Error{
    case noResponse
    case responseError(Int) //HTTP response codes
    case noData
    case couldNotParseData
}

class Networking{
    
}

//TODO: change Networking into an enum for .getJson, .post examples
typealias NetworkingFunction = Networking
extension NetworkingFunction: NetworkProtocol{
    
    func getWeather(by type: QueryType, completion: @escaping (CityWeather?, Error?) -> ()) {
        var myUrl = String()
        switch type{
        case .cityId(let myId):  //forecast is different from weather.
            myUrl = "http://api.openweathermap.org/data/2.5/weather?id=\(myId)&appid=\(GlobalStuff.bearer)"
        case .cityName(let myName):
            myUrl = "http://api.openweathermap.org/data/2.5/weather?q=\(myName)&appid=\(GlobalStuff.bearer)"
        case .geographicCooridinates(let lat, let lon):
            myUrl = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(GlobalStuff.bearer)"
        case .zipCode(let myZipCode):
            myUrl = "http://api.openweathermap.org/data/2.5/weather?zip=\(myZipCode),us&appid=\(GlobalStuff.bearer)"
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
                print(uurl)
                let temp = try JSONDecoder().decode(CityWeather.self, from: data)
                completion(temp,nil)
            }catch let error{
                print("Serialization Error")
                completion(nil, error)
            }
        }
    }
    
    func getForcastWeek(by type: QueryType, completion: @escaping (ForecastWeek?, Error?) -> ())  {
        var myUrl = String()
        switch type{
        case .cityId(let myId):
            myUrl = "http://samples.openweathermap.org/data/2.5/forecast/daily?id=\(myId)&appid=\(GlobalStuff.bearer)"//&lang=\(en)
        case .cityName(let myName):
            myUrl = "http://samples.openweathermap.org/data/2.5/forecast?q=\(myName)&appid=\(GlobalStuff.bearer)"
        case .geographicCooridinates(let lat, let lon):
            myUrl = "http://samples.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(GlobalStuff.bearer)"
        case .zipCode(let myZipCode):
            myUrl = "http://samples.openweathermap.org/data/2.5/forecast?zip=\(myZipCode),us&appid=\(GlobalStuff.bearer)"
        }

        guard let uurl = URL(string:myUrl) else {return}
        Alamofire.request(uurl).response { (dataResponse) in
            guard dataResponse.error == nil else {  //error
                guard let resp = dataResponse.response else {
                    completion(nil, NetworkingError.noResponse)
                    return
                }
                completion(nil, NetworkingError.responseError(resp.statusCode))
                return
            }
            
            guard let data = dataResponse.data else {
                //no data
                completion(nil, NetworkingError.noData)
                return
            }
            do{
                print(uurl)
                let temp = try JSONDecoder().decode(ForecastWeek.self, from: data)
                completion(temp,nil)
            }catch let error{
                print(NetworkingError.couldNotParseData)
                completion(nil, error)//maybe send back NetworkingError.couldNot.. instead
            }
        }
    }
}

