//
//  WeatherIcon.swift
//  VOSWeather
//
//  Created by Vincent O'Sullivan on 28/02/2016.
//  Copyright © 2016 Vincent O'Sullivan. All rights reserved.
//

typealias WindDirection = (direction: String, heading: String, icon: String)
struct WeatherDetails {
    
    static func windDirection4(degrees d: Double) -> WindDirection {
        let deg = d % 360.0
        switch deg {
        case 0..<45.0, 315.0..<360.0:
            return (direction: "North", "Northerly", "\u{f044}")
        case 45.0..<135.0:
            return (direction: "East", "Northerly", "\u{f04d}")
        case 135.0..<225.0:
            return (direction: "South", "Northerly", "\u{f058}")
        case 225.0..<315.0:
            return (direction: "West", "Northerly", "\u{f048}")
        default:
            return (direction: "Everywhere", "Vertically", "\u{f095}")
        }
    }
    
    static func windDirection8(degrees d: Double) -> WindDirection {
        let deg = d % 360.0
        switch deg {
        case 0..<45.0, 135..<360.0:
            return (direction: "North", "Northerly", "\u{f0b1}")
        default:
            return (direction: "Everywhere", "Vertically", "\u{f095}")
        }
    }
    
    static func windDirection16(degrees d: Double) -> WindDirection {
        let deg = d % 360.0
        switch deg {
        case 0..<45.0, 135..<360.0:
            return (direction: "North", "Northerly", "\u{f0b1}")
        default:
            return (direction: "Everywhere", "Vertically", "\u{f095}")
        }
    }
    
    static func windDirection32(degrees d: Double) -> WindDirection {
        let deg = d % 360.0
        switch deg {
        case 0..<45.0, 135..<360.0:
            return (direction: "North", "Northerly", "\u{f0b1}")
        default:
            return (direction: "Everywhere", "Vertically", "\u{f095}")
        }
    }
    
    static func windDirection64(degrees d: Double) -> WindDirection {
        let deg = d % 360.0
        switch deg {
        case 0..<45.0, 135..<360.0:
            return (direction: "North", "Northerly", "\u{f0b1}")
        default:
            return (direction: "Everywhere", "Vertically", "\u{f095}")
        }
    }
}
