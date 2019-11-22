//
//  ChangeCityVC.swift
//  Stormwind
//
//  Created by Omar on 11/5/19.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

protocol PickWeatherDetailsDelegate {
    func weatherData(cityName: String, temp: String, weatherIcon: UIImage)
}

class ChangeCityVC: UIViewController {
    
    @IBOutlet weak var searchCity_tf: UITextField!
    
    var delegate: PickWeatherDetailsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getWeatherBtn(_ sender: UIButton) {
        guard !(searchCity_tf.text?.isEmpty)! else {
            self.showAlert(title: "Wait!", message: "Please type the city name.")
            return
        }
        
        searchCity_tf.endEditing(true)
        
        Api.getWeatherForSearchedCity(controller: self, city: searchCity_tf.text!) { (error, weather) in
            if let error = error {
                print(error.localizedDescription)
                self.showAlert(title: "Opps!", message: error.localizedDescription)
            } else if let weather = weather {
                self.delegate?.weatherData(cityName: weather.name, temp: weather.main.tempString, weatherIcon: UIImage(named: weather.getConditionNames(weatherId: weather.weather[0].id))!)
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}
