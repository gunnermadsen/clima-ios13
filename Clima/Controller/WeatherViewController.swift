//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?q=spokane&units=imperial"
    let APP_ID = "2bf33d2dfb6952c98b04d5aeb947b505"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
}

//MARK: - UITextFieldDelgate


extension WeatherViewController: UITextFieldDelegate {
    
     @IBAction func searchPressed(_ sender: UIButton) {
         searchTextField.endEditing(true)
         print(searchTextField.text!)
     }
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         searchTextField.endEditing(true)
         print(searchTextField.text!)
         return true
     }
     
     func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         
         if textField.text != "" {
             return true
         } else {
             textField.placeholder = "Enter a city"
             return false
         }
     }
     
     func textFieldDidEndEditing(_ textField: UITextField) {
         // use searchField.text to get the weather for city
         if let city = searchTextField.text {
             weatherManager.fetchWeather(cityName: city)
         }
         searchTextField.text = ""
     }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

