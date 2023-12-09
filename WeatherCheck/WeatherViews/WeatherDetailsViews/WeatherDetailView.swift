//
//  WeatherDetailView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-24.
//

import SwiftUI

struct WeatherDetailView: View {
    var weatherData: Weathernetworkmodel
 
    
    var body: some View {
        VStack(spacing: 10) {
            Text("My Location")
                .font(.title)
                .bold()
            Text(weatherData.timezone ?? "Unknown Location")
                .font(.caption)
            Text("\(weatherData.current?.temp ?? 0, specifier: "%.0f°")")
                .font(.system(size: 80))
                .fontWeight(.bold)
            Text(weatherData.current?.weather?.first?.description?.rawValue.capitalizingFirstLetterOfEachWord() ?? "Unknown")
                .font(.title3)
            Text("H:\(weatherData.daily?.first?.temp?.max ?? 0, specifier: "%.0f°") L:\(weatherData.daily?.first?.temp?.min ?? 0, specifier: "%.0f°")")
                .font(.caption)
        }
        .padding()
    }
}


struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(weatherData: mockWeatherData)
    }

    static var mockWeatherData: Weathernetworkmodel {
        Weathernetworkmodel(
            lat: 52.1332,
            lon: -106.6700,
            timezone: "Saskatoon",
            timezoneOffset: -21600,
            current: Current(
                dt: 1605000000,
                sunrise: 1605020000,
                sunset: 1605056000,
                temp: 23.0,
                feelsLike: 21.0,
                pressure: 1015,
                humidity: 65,
                dewPoint: 16.0,
                uvi: 5.0,
                clouds: 75,
                visibility: 10000,
                windSpeed: 5.0,
                windDeg: 200,
                weather: [Weather(
                    id: 800,
                    main: .clear,
                    description: .clearSky,
                    icon: "01d"
                )],
                windGust: nil,
                pop: nil,
                rain: nil
            ),
            minutely: nil,
            hourly: nil,
            daily: [
                Daily(
                    dt: 1605000000,
                    sunrise: 1605020000,
                    sunset: 1605056000,
                    moonrise: 1605000000,
                    moonset: 1605030000,
                    moonPhase: 0.25, summary: "Cloudy",
                    temp: Temp(
                        day: 23.0,
                        min: 18.0,
                        max: 25.0,
                        night: 20.0,
                        eve: 22.0,
                        morn: 19.0
                    ),
                    feelsLike: FeelsLike(
                        day: 21.0,
                        night: 19.0,
                        eve: 20.0,
                        morn: 18.0
                    ),
                    pressure: 1015,
                    humidity: 65,
                    dewPoint: 16.0,
                    windSpeed: 5.0,
                    windDeg: 200,
                    windGust: 7.0,
                    weather: [Weather(
                        id: 800,
                        main: .clear,
                        description: .clearSky,
                        icon: "01d"
                    )],
                    clouds: 0,
                    pop: 0,
                    uvi: 5.0,
                    rain: 0.0
                )
            ]
        )
    }
}
