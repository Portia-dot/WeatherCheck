//
//  ReuseableFunctions.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-12-08.
//

// ReuseableFunctions.swift

import SwiftUI

func backgroundView(for weatherData: Weathernetworkmodel, isFullScreen: Bool) -> (view: some View, isDayTime: Bool) {
    let isDayTime = checkIfDayTime(weatherData: weatherData)
    
//    if let weatherCondition = weatherData.current?.weather?.first?.description {
//        return WeatherBackgroundView(weatherCondition: weatherCondition, isDayTime: isDayTime, isFullScreen: isFullScreen)
//    } else {
//        return WeatherBackgroundView(weatherCondition: .clearSky, isDayTime: true, isFullScreen: isFullScreen)
//    }
    let view = weatherData.current?.weather?.first?.description.map{
        WeatherBackgroundView(weatherCondition: $0, isDayTime: isDayTime, isFullScreen: isFullScreen)
    } ?? WeatherBackgroundView(weatherCondition: .clearSky, isDayTime: true, isFullScreen: isFullScreen)
    
    return (view, isDayTime)
}

func checkIfDayTime(weatherData: Weathernetworkmodel) -> Bool {
    if let current = weatherData.current {
        let now = Date().timeIntervalSince1970
        return now >= Double(current.sunrise ?? 0) && now < Double(current.sunset ?? 0)
    }
    return true
}

