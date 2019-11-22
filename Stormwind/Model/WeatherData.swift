//
//  WeatherModel.swift
//  Stormwind
//
//  Created by Omar on 11/21/19.
//  Copyright © 2019 Omar. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    func getConditionNames(weatherId: Int) -> String {
        switch weatherId {
        case 200...232:
            return "thunderStorm"
        case 300...321:
            return "sunny.cloud.bolt"
        case 500...511:
            return "light_rain"
        case 520...531:
            return "showerRain"
        case 600...615:
            return "lightSnow"
        case 616...622:
            return "heavySnow"
        case 701...781:
            return "mist"
        case 800:
            return "sunny"
        case 801...802:
            return "fewClouds"
        case 803...804:
            return "clouds"
        default:
            return "dunno"
        }
    }
}

struct Main: Codable {
    let temp: Double
    var tempString: String {
        return String(format: "%.1f", temp)
    }
}

struct Weather: Codable {
    let id: Int
}
