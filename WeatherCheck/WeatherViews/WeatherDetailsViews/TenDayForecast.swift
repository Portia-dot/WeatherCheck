//
//  TenDayForecast.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-12-17.
//

import SwiftUI



struct TenDayForecast: View {
    var dailyForecast: [Daily]
    var timezoneOffset: Int
    var cardData: WeatherCardData
    
    var body: some View {
        let background = backgroundView(for: cardData.weatherData, isFullScreen: true)
        let weekMinTemperature = dailyForecast.min(by: { $0.temp?.min ?? 0 < $1.temp?.min ?? 0 })?.temp?.min ?? 0
        let weekMaxTemperature = dailyForecast.max(by: { $0.temp?.max ?? 0 > $1.temp?.max ?? 0 })?.temp?.max ?? 0
        
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                Text("10-DAY FORECAST")
                    .font(.footnote)
                    .fontWeight(.black)
            }
            CustomDivider(color: background.isDayTime ? .black : .white)
            
            ForEach(dailyForecast, id: \.dt) { forecast in
                HStack { 
                    Text(getDayLabel(for: forecast.dt, timezoneOffset: timezoneOffset))
                        .font(.system(size: 15, weight: .black, design: .default))
                    Spacer()
                    WeatherIconView(iconCode: forecast.weather?.first?.icon ?? "01d")
                        .frame(width: 30, height: 30)
                    Spacer()
                    Text("\(forecast.temp?.min?.kelvinToCelsiusString() ?? "N/A")°C")
                        .font(.system(size: 15, weight: .black))
                    Spacer()
                    // Ensure you handle nil safely here
                    if let minTemp = forecast.temp?.min, let maxTemp = forecast.temp?.max {
                        CustomTempratureBar(dayMinTemperature: minTemp, dayMaxTemperature: maxTemp, fullRangeMinTemperature: weekMinTemperature, fullRangeMaxTemperature: weekMaxTemperature)
                        Spacer()
                    }
                   
                    Text("\(forecast.temp?.max?.kelvinToCelsiusString() ?? "N/A")°C")
                        .font(.system(size: 15, weight: .black))
                    Spacer()
                }
                
                CustomDivider(color: background.isDayTime ? .black : .white)
            }
        }
    }
    
    private func getDayLabel(for unixTime: Int?, timezoneOffset: Int) -> String {
        guard let unixTime = unixTime else { return "N/A" }
        let date = Date.from(unixTime: unixTime, with: timezoneOffset)
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else {
            return date.dayOfWeek(using: timezoneOffset)
        }
    }
}

private func getDayLabel(for unixTime:Int?, timezoneOffset: Int ) -> String {
    guard let unixTime = unixTime else {return "N/A"}
    let date = Date.from(unixTime: unixTime, with: timezoneOffset)
    let calendar = Calendar.current
    
    if calendar.isDateInToday(date){
        return "Today"
    }else{return date.dayOfWeek(using: timezoneOffset)}
}

struct TenDayForecast_Previews: PreviewProvider {
    static var previews: some View {
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
        TenDayForecast(dailyForecast: mockCardData.weatherData.daily ?? [], timezoneOffset: mockCardData.weatherData.timezoneOffset ?? 0, cardData: mockCardData)
    }
}

extension Date {
    func dayOfWeek(using timezoneOffset: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezoneOffset)
        return dateFormatter.string(from: self)
    }
    static func from(unixTime: Int, with timezoneOffset: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(unixTime)).addingTimeInterval(TimeInterval(timezoneOffset))
    }
}
