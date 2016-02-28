//
//  WeatherManager.swift
//  VOSWeather
//
//  Created by Vincent O'Sullivan on 27/02/2016.
//  Copyright © 2016 Vincent O'Sullivan. All rights reserved.
//

import Foundation

public class WeatherManager {
    
    let latitude = 51.3
    let longitude = -1.0
    
    public class func getWeatherWithSuccess(success: ((data: NSData) -> Void)) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let filePath = NSBundle.mainBundle().pathForResource("topapps", ofType:"json")
            let data = try! NSData(contentsOfFile:filePath!,
                options: NSDataReadingOptions.DataReadingUncached)
            success(data: data)
        })
    }
    
    func fetchCurrentWeatherData(completion:(data: NSData?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let weatherURL = currentWeatheGeoURL(latitude: latitude, longitude: longitude)
        let loadDataTask = session.dataTaskWithURL(weatherURL) { (data, response, error) -> Void in
            if let error = error {
                completion(data: nil, error: error)
            } else if let response = response as? NSHTTPURLResponse {
                if response.statusCode != 200 {
                    let statusError = NSError(
                        domain: "com.vjosullivan",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        }
        
        loadDataTask.resume()
    }
    
    func fetchCurrentWeather(completion: (CurrentWeather) -> ()) {
        fetchCurrentWeatherData() {(data, error) in
            if let data = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
                    let currentWeather = self.parseCurrentWeather(json)
                    completion(currentWeather)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func fetchForecastWeatherData(completion:(data: NSData?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let weatherURL = forecastWeatherGeoURL(latitude: latitude, longitude: longitude)
        let loadDataTask = session.dataTaskWithURL(weatherURL) { (data, response, error) -> Void in
            if let error = error {
                completion(data: nil, error: error)
            } else if let response = response as? NSHTTPURLResponse {
                if response.statusCode != 200 {
                    let statusError = NSError(
                        domain: "com.vjosullivan",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        }
        
        loadDataTask.resume()
    }
    
    func fetchForecastWeather(completion: (ForecastWeather) -> ()) {
        fetchForecastWeatherData() {(data, error) in
            if let data = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
                    let ForecastWeather = self.parseForecastWeather(json)
                    completion(ForecastWeather)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func parseCurrentWeather(json: [String: AnyObject]) -> CurrentWeather {
        let weather = CurrentWeather()
        weather.cod       = json["cod"] as? Int ?? 0
        weather.base      = json["base"] as? String ?? ""
        weather.station   = json["name"] as? String ?? ""
        weather.stationID = json["id"] as? Int ?? 0
        if let summary = json["weather"]?[0] as? [String: AnyObject] {
            weather.weatherIcon     = summary["icon"] as? String ?? "000"
            weather.weatherID       = summary["id"] as? Int ?? 0
            weather.weatherName     = summary["main"] as? String ?? ""
            weather.weatherIconName = summary["description"] as? String ?? ""
        }
        if let wind = json["wind"] as? [String: AnyObject] {
            weather.windSpeed     = wind["speed"] as? Double ?? 0.0
            weather.windDirection = wind["deg"] as? Double ?? 0.0
        }
        if let clouds = json["clouds"] as? [String: AnyObject] {
            weather.cloudCover = clouds["all"] as? Int ?? 0
        }
        if let rain = json["rain"] as? [String: AnyObject] {
            weather.rain3h = rain["3h"] as? Int ?? 0
        }
        if let snow = json["snow"] as? [String: AnyObject] {
            weather.snow3h = snow["3h"] as? Int ?? 0
        }
        weather.lastUpdated = json["dt"] as? Int ?? 0
        if let station = json["coord"] as? [String: AnyObject] {
            weather.stationLatitude  = station["lat"] as? Double ?? 0.0
            weather.stationLongitude = station["lon"] as? Double ?? 0.0
        }
        if let sys = json["sys"] as? [String: AnyObject] {
            weather.sysType    = sys["type"] as? Int ?? 0
            weather.sysID      = sys["id"] as? Int ?? 0
            weather.sysMessage = sys["message"] as? Double ?? 0.0
            weather.country    = sys["country"] as? String ?? ""
            weather.sunrise    = sys["sunrise"] as? Int ?? 0
            weather.sunset     = sys["sunset"] as? Int ?? 0
        }
        if let main = json["main"] as? [String: AnyObject] {
            weather.temperature         = main["temp"] as? Double ?? 0.0
            weather.temperatureMin      = main["temp_min"] as? Double ?? 0.0
            weather.temperatureMax      = main["temp_max"] as? Double ?? 0.0
            weather.humidity            = main["humidity"] as? Int ?? 0
            weather.pressure            = main["pressure"] as? Int ?? 0
            weather.pressureSeaLevel    = main["sea_level"] as? Int ?? 0
            weather.pressureGroundLevel = main["grnd_level"] as? Int ?? 0
        }
        
        return weather
    }
    
    func parseForecastWeather(json: [String: AnyObject]) -> ForecastWeather {
        let forecast = ForecastWeather()
        forecast.cod = json["cod"] as? Int ?? 0
        
        return ForecastWeather()
    }
    
    private func imageURL(iconCode: String) -> NSURL {
        return NSURL(string: "http://openweathermap.org/img/w/\(iconCode).png")!
        
    }
    
    private func forecastWeatherGeoURL(latitude latitude: Double, longitude: Double) -> NSURL {
        return NSURL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=21ecb2e5a924334fb56ee25bf83550b8")!
    }
    
    private func currentWeatheGeoURL(latitude latitude: Double, longitude: Double) -> NSURL {
        return NSURL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=21ecb2e5a924334fb56ee25bf83550b8")!
    }
}

