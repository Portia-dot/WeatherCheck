//
//  WeatherHomeCard.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-24.
//

import SwiftUI

struct WeatherHomeCard: View {
    var weatherData: Weathernetworkmodel
    var viewModel: WeatherViewModel

    var body: some View {
        ZStack {
            backgroundView()
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.clear)
                .overlay(
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(viewModel.cityName ?? "Unknown Location")
                                    .font(.subheadline)
                                    .fontWeight(.black)
                                Text(formatUnixTimeStamp(weatherData.current?.dt ?? 0, timezone: weatherData.timezone ?? "UTC"))
                                    .font(.footnote)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            Text("\(weatherData.current?.temp ?? 0, specifier: "%.0f")°")
                                .font(.title)
                                .fontWeight(.black)
                        }
                        .padding()
                        HStack {
                            Text(weatherData.current?.weather?.first?.description?.rawValue.capitalizingFirstLetterOfEachWord() ?? "Unknown")
                                .font(.footnote)
                                .fontWeight(.bold)
                            Spacer()
                            Text("H:\(weatherData.daily?.first?.temp?.max ?? 0, specifier: "%.0f°") L:\(weatherData.daily?.first?.temp?.min ?? 0, specifier: "%.0f°")")
                                .font(.footnote)
                                .fontWeight(.bold)
                        }
                        .padding()
                    }
                    .padding()
                )
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
        }
    }

    private func backgroundView() -> some View {
         let isDayTime = viewModel.isDayTime
         
         if let currentWeather = viewModel.weatherData?.current,
            let weatherCondition = currentWeather.weather?.first?.description
         {
             return WeatherBackgroundView(weatherCondition: weatherCondition, isDayTime: isDayTime, isFullScreen: false)
         }else {
             return WeatherBackgroundView(weatherCondition: .clearSky, isDayTime: true, isFullScreen: false)
         }
     }
    
    private func formatUnixTimeStamp(_ timestamp: Int, timezone: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        formatter.timeZone = TimeZone(identifier: timezone)
        return formatter.string(from: date)
    }
}

extension String {
    func capitalizingFirstLetterOfEachWord() -> String {
        return self.lowercased().split(separator: " ").map { $0.capitalized }.joined(separator: " ")
    }
}

struct WeatherCard_Previews: PreviewProvider {
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

        // Use the mock data in the preview
        WeatherHomeCard(weatherData: mockWeatherData, viewModel: WeatherViewModel())
    }
}


