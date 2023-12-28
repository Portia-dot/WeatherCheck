//
//  WeatherModelNetwork.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-28.
//

import SwiftUI


// MARK: - Weathernetworkmodel
struct Weathernetworkmodel: Decodable, Hashable {
    let lat, lon: Double?
    let timezone: String?
    let timezoneOffset: Int?
    let current: Current?
    let minutely: [Minutely]?
    let hourly: [Current]?
    let daily: [Daily]?
}

// MARK: - Current
struct Current: Decodable, Hashable {
    let dt, sunrise, sunset: Int?
    let temp, feelsLike: Double?
    let pressure, humidity: Int?
    let dewPoint, uvi: Double?
    let clouds, visibility: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let weather: [Weather]?
    let windGust, pop: Double?
    let rain: Rain?
}

// MARK: - Rain
struct Rain: Decodable, Hashable {
    let the1H: Double?
}

// MARK: - Weather
struct Weather: Decodable, Hashable {
    let id: Int?
    let main: Main?
    let description: Description?
    let icon: String?
}

enum Description: String, Decodable {
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let descriptionString = try container.decode(String.self)
        self = Description(rawValue: descriptionString) ?? .unknown
    }
}

enum Main: String, Codable, Hashable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
    case haze = "Haze"
    case mist = "Mist"
    case unknown 
    
    
    init(from decoder: Decoder) throws {
           let container = try decoder.singleValueContainer()
           let stringValue = try container.decode(String.self)
           self = Main(rawValue: stringValue) ?? .unknown
       }
}

// MARK: - Daily
struct Daily: Decodable, Hashable {
    let dt, sunrise, sunset, moonrise: Int?
    let moonset: Int?
    let moonPhase: Double?
    let summary: String?
    let temp: Temp?
    let feelsLike: FeelsLike?
    let pressure, humidity: Int?
    let dewPoint, windSpeed: Double?
    let windDeg: Int?
    let windGust: Double?
    let weather: [Weather]?
    let clouds, pop: Double?
    let uvi, rain: Double?
}

// MARK: - FeelsLike
struct FeelsLike: Decodable, Hashable {
    let day, night, eve, morn: Double?
}

// MARK: - Temp
struct Temp: Decodable, Hashable {
    let day, min, max, night: Double?
    let eve, morn: Double?
}

// MARK: - Minutely
struct Minutely: Decodable, Hashable {
    let dt : Int?
    let precipitation: Double?
}

