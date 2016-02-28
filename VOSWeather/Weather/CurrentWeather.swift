//
//  CurrentWeather.swift
//  VOSWeather
//
//  Created by Vincent O'Sullivan on 27/02/2016.
//  Copyright © 2016 Vincent O'Sullivan. All rights reserved.
//

import Foundation

class CurrentWeather {
    
    /// City description.
    var cod: Int?
    /// Internal parameter.
    var base: String?
    /// City name.
    var station = ""
    /// City ID.
    var stationID: Int?
    
    /// Weather condition ID.
    var weatherID: Int?
    /// Weather icon ID.
    var weatherIcon: String?
    /// Group of weather parameters (Rain, Snow, Extreme etc.)
    var weatherName: String?
    /// Weather condition within the group
    var weatherIconName: String?
    
    /// Wind speed. <br>Unit Default: `meter/sec`, <br>Metric: `meter/sec`, <br>Imperial: `miles/hour`.
    var windSpeed = 0.0
    /// Wind direction, degrees (meteorological)
    var windDirection = 0.0
    /// Cloudiness, %
    var cloudCover = 0
    /// Rain in last three hours (mm).
    var rain3h = 0
    /// Snow in last three hours (mm).
    var snow3h = 0
    
    /// Time of data calculation, unix, UTC.
    var lastUpdated: Int?
    
    /// City geo location, longitude
    var stationLatitude = 0.0
    /// City geo location, latitude
    var stationLongitude = 0.0
    
    /// Internal parameter.
    var sysType: Int?
    /// Internal parameter.
    var sysID: Int?
    /// Internal parameter.
    var sysMessage: Double?
    /// Country code (GB, JP etc.)
    var country = ""
    /// Sunrise time, unix, UTC.
    var sunrise: Int?
    /// Sunset time, unix, UTC.
    var sunset: Int?
    
    /// Temperature. <br>Units <br>Default: `Kelvin`, <br>Metric: `Celsius`, <br>Imperial: `Fahrenheit`.
    var temperature: Double?
    /// Minimum temperature at the moment. <br>This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). <br>Units <br>Default: `Kelvin`, <br>Metric: `Celsius`, <br>Imperial: `Fahrenheit`.
    var temperatureMin: Double?
    /// Maximum temperature at the moment. <br>This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). <br>Units <br>Default: `Kelvin`, <br>Metric: `Celsius`, <br>Imperial: `Fahrenheit`.
    var temperatureMax: Double?
    /// Humidity, %.
    var humidity = 0
    /// Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), `hPa`.
    var pressure = 0
    /// Atmospheric pressure on the sea level, `hPa`.
    var pressureSeaLevel = 0
    /// Atmospheric pressure on the ground level, `hPa`.
    var pressureGroundLevel = 0
    
    func sunriseTime() -> String {
        let date = NSDate(timeIntervalSince1970: Double(sunrise!))
        let format = NSDateFormatter()
        format.timeStyle = NSDateFormatterStyle.ShortStyle
        return format.stringFromDate(date)
    }
    
    func sunsetTime() -> String {
        let date = NSDate(timeIntervalSince1970: Double(sunset!))
        let format = NSDateFormatter()
        format.timeStyle = NSDateFormatterStyle.ShortStyle
        return format.stringFromDate(date)
    }
    
    func lastUpdatedTime() -> String {
        let date = NSDate(timeIntervalSince1970: Double(lastUpdated!))
        let format = NSDateFormatter()
        format.timeStyle = NSDateFormatterStyle.ShortStyle
        return format.stringFromDate(date)
    }
    
    func compass(degrees: Double) -> String {
        switch degrees {
        case 0.0..<22.5, 337.5..<360:
            return "Northerly"
        case 22.5..<67.5:
            return "Northeasterly"
        case 67.5..<112.5:
            return "Easterly"
        case 112.5..<157.5:
            return "Southeasterly"
        case 157.5..<202.5:
            return "Southerly"
        case 202.5..<247.5:
            return "Southwesterly"
        case 247.5..<292.5:
            return "Westerly"
        case 292.5..<337.5:
            return "Northwesterly"
        default:
            return "All directions!"
        }
    }
}

extension CurrentWeather: CustomStringConvertible {
    
    var description: String {
        let s1 = "\n\nCurrentWeather:\n\n" +
            "status: \(cod ?? 0))\n" +
            "base: \(base)\n"
        let s1a = "system: type \(sysType), ID \(sysID), message \(sysMessage)\n" +
            "station: \(station) \(country): (\(stationLatitude)°, \(stationLongitude)°)\n"
        let s1b = "sunrise: \(sunrise)\n" +
            "sunset: \(sunset)\n"
        let s2 = "station ID: \(stationID)\n" +
            "weather ID: \(weatherID)\n" +
            "weather Icon: \(weatherIcon)\n" +
            "weather Name: \(weatherName)\n" +
            "weather Description: \(weatherIconName)\n"
        let s3 = "wind speed: \(windSpeed) m/s\n" +
            "wind direction: \(windDirection)°\n" +
            "cloud cover: \(cloudCover)%\n" +
            "rain (3 hrs): \(rain3h)mm\n" +
            "snow (3 hrs): \(snow3h)mm\n"
        let s3a = "temperature: \(temperature)K (between \(temperatureMin)K and \(temperatureMax)K)\n" +
            "humidity: \(humidity)%\n"
        let s4 = "pressure: \(pressure)hPa (Sea level: \(pressureSeaLevel)hPa, ground level: \(pressureGroundLevel)hPa)\n" +
            "reading date: \(lastUpdated) \n"
        return s1 + s1a + s1b + s2 + s3 + s3a + s4
    }
}