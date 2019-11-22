//
//  ViewController.swift
//  Stormwind
//
//  Created by Omar on 11/5/19.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, PickWeatherDetailsDelegate {
    
    @IBOutlet weak var temperature_lbl: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var city_lbl: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func currentLocationWeather(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func changeCityBtn(_ sender: UIButton) {
        guard let changeCityVC = storyboard?.instantiateViewController(withIdentifier: "ChangeCityVC") as? ChangeCityVC else {return}
        changeCityVC.delegate = self
        navigationController?.pushViewController(changeCityVC, animated: true)
    }
    
    func weatherData(cityName: String, temp: String, weatherIcon: UIImage) {
        DispatchQueue.main.async {
            self.city_lbl.text = cityName
            self.temperature_lbl.text = temp
            self.weatherIcon.image = weatherIcon
        }
    }
}

extension WeatherVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        locationManager.stopUpdatingLocation()
        
        Api.getWeather(controller: self, latitude: latitude, longitude: longitude) { (error, weather) in
            if let error = error {
                self.city_lbl.text = ""
                self.temperature_lbl.text = ""
                self.weatherIcon.image = UIImage(named: "dunno")
                self.showAlert(title: "Something went wrong!", message: "\(error.localizedDescription)")
                return
            } else if let weather = weather {
                DispatchQueue.main.async {
                    self.city_lbl.text = weather.name
                    self.temperature_lbl.text = "\(weather.main.tempString)"
                    self.weatherIcon.image = UIImage(named: weather.getConditionNames(weatherId: weather.weather[0].id))
                }
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        self.city_lbl.text = "Location Unavailable"
        self.showAlert(title: "Something went wrong!", message: "\(error.localizedDescription)")
    }
    
}
