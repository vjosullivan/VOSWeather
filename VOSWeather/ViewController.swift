//
//  ViewController.swift
//  VOSWeather
//
//  Created by Vincent O'Sullivan on 27/02/2016.
//  Copyright © 2016 Vincent O'Sullivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var station: UILabel!
    @IBOutlet weak var weatherHeading: UILabel!
    @IBOutlet weak var weatherIcon: UILabel!
    @IBOutlet weak var weatherIconName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var rain3h: UILabel!
    @IBOutlet weak var snow3h: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!

    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var cloudCover: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunset: UILabel!
    
    // MARK: - Properties
    
    let weatherManager = WeatherManager()
    
    // MARK: - Actions
    
    @IBAction func fetchWeather() {
        weatherManager.fetchCurrentWeather() { (weather) in
            self.refreshWeatherDisplay(weather)
            print(weather)
        }
    }
    
    // MARK: - UIViewController Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sunriseLabel.text = "\u{f051}"
        sunsetLabel.text  = "\u{f052}"
        fetchWeather()
    }
    
    func refreshWeatherDisplay(weather: CurrentWeather) {
        dispatch_async(dispatch_get_main_queue()) {
            self.station.text = "\(weather.station), \(weather.country) (\(weather.stationLatitude)°, \(weather.stationLongitude)°)"
            self.weatherHeading.text = weather.weatherName
            self.weatherIcon.text = self.iconFrom(code: weather.weatherIcon!)
            self.weatherIconName.text = weather.weatherIconName
            let tK = weather.temperature!.toString(1)
            let tC = (weather.temperature! - 273.15).toString(1)
            let tF = ((weather.temperature! - 273.15) * 1.8 + 32.0).toString(1)
            
            self.temperature.text = "\(tK)K (\(tC)°C, \(tF)°F)"
            self.rain3h.text = "\(weather.rain3h)mm in last 3 hours"
            self.snow3h.text = "\(weather.snow3h)mm in last 3 hours"
            self.pressure.text = "\(weather.pressure)hPa"
            self.humidity.text = "\(weather.humidity)%"
            let windDirection = WeatherDetails.windDirection4(degrees: weather.windDirection)
            self.windLabel.text = windDirection.icon
            self.wind.text = "\(weather.windSpeed)m/s from the \(windDirection.direction.lowercaseString). (\(weather.windDirection.toString(0))°)"
            self.cloudCover.text = "\(weather.cloudCover)%"
            self.lastUpdated.text = "\(weather.lastUpdatedTime())"
            self.sunrise.text = "\(weather.sunriseTime())"
            self.sunset.text = "\(weather.sunsetTime())"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func iconFrom(code code: String) -> String {
        let icon: String
        print (code)
        switch code {
        case "03d":
            icon = "\u{f07d}" // wi-owm-day-804: day-sunny-overcast
        case "04d":
            icon = "\u{f07d}" // wi-owm-day-804: day-sunny-overcast
        default:
            icon = "\u{f00d}" // wi-owm-day-800: day-sunny
        }
        return icon
    }
}

extension Double {
    
    func toString(fractionDigits:Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.stringFromNumber(self) ?? "\(self)"
    }
}


