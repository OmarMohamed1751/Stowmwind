//
//  Api.swift
//  Stormwind
//
//  Created by Omar on 11/5/19.
//  Copyright © 2019 Omar. All rights reserved.
//

import Foundation
import Alamofire

class Api {
    // get user's local weather
    static func getWeather(controller: UIViewController,latitude: String, longitude: String, completion: @escaping( _ error: Error?, _ weather: WeatherData?) -> Void) {
        let url = Urls.WEATHER_URL
        let params = [
            "lat" : latitude,
            "lon" : longitude
        ]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .failure:
                guard let error = response.error else {return}
                print("faild because \(error.localizedDescription)")
                controller.showAlert(title: "Opps!", message: error.localizedDescription)
                completion(error, nil)
                
            case .success:
                guard let data = response.data else {return}
                let decoder = JSONDecoder()
                do {
                    let decodedweatherData = try decoder.decode(WeatherData.self, from: data)
                    completion(nil, decodedweatherData)
                } catch {
                    print(error.localizedDescription)
                    controller.showAlert(title: "Opps!", message: error.localizedDescription)
                }
                
            }
        }
    }

    // get weather for the searched city
    static func getWeatherForSearchedCity(controller: UIViewController, city: String, completion: @escaping(_ error: Error?, _ weather: WeatherData?) -> Void) {
        let url = "\(Urls.WEATHER_URL)&q=\(city)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure:
                guard let error = response.error else {return}
                print("faild because \(error.localizedDescription)")
                controller.showAlert(title: "Opps!", message: error.localizedDescription)
                completion(error, nil)
                
            case .success:
                guard let data = response.data else {return}
                let decoder = JSONDecoder()
                do {
                    let decodedweatherData = try decoder.decode(WeatherData.self, from: data)
                    completion(nil, decodedweatherData)
                } catch {
                    print(error.localizedDescription)
                    controller.showAlert(title: "Opps!", message: error.localizedDescription)
                }
            }
        }
    }
    
}
