//
//  WeatherDetailView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-24.
//

import SwiftUI

struct WeatherDetailView: View {
    var cardData: WeatherCardData
 
    
    var body: some View {
        let background = backgroundView(for: cardData.weatherData, isFullScreen: true)
        ZStack {
            background.view
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                Text("My Location")
                    .font(.title)
                    .bold()
                Text(cardData.cityName )
                    .font(.caption)
                Text("\(cardData.weatherData.current?.temp ?? 0, specifier: "%.0f°")")
                    .font(.system(size: 80))
                    .fontWeight(.bold)
                Text(cardData.weatherData.current?.weather?.first?.description?.rawValue.capitalizingFirstLetterOfEachWord() ?? "Unknown")
                    .font(.title3)
                Text("H:\(cardData.weatherData.daily?.first?.temp?.max ?? 0, specifier: "%.0f°") L:\(cardData.weatherData.daily?.first?.temp?.min ?? 0, specifier: "%.0f°")")
                    .font(.caption)
            }
            .padding()
            .foregroundStyle(background.isDayTime ? .black :.white)
            
        }
    }
}


struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock instance of Weathernetworkmodel
        let mockWeatherData = Weathernetworkmodel(
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
                    moonPhase: 0.25,
                    summary: "Clear day",
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
        let mockCardData = WeatherCardData(cityName: "Saskatoon", weatherData: mockWeatherData)
        // Use the mock data in the preview
        WeatherDetailView(cardData: mockCardData)
    }
}
