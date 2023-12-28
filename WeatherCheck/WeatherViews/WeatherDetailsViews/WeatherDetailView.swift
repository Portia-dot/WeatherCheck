//
//  WeatherDetailView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-24.
//

import SwiftUI

struct WeatherDetailView: View {
    var cardData: WeatherCardData
    var currentLocation: Bool
    
    
    var body: some View {
        //HourlyFilter
        let currentTimestamp = Int(Date().addingTimeInterval(TimeInterval(cardData.weatherData.timezoneOffset ?? 0)).timeIntervalSince1970)
        let futureHourlyForecast = cardData.weatherData.hourly?.filter { hourData in
            guard let hourTimestamp = hourData.dt else { return false }
            return hourTimestamp >= currentTimestamp
        } ?? []
        //Backgrounds
        let background = backgroundView(for: cardData.weatherData, isFullScreen: true)
        let dailyForecasts = cardData.weatherData.daily?.prefix(10) ?? []
        let timezoneOffSet = cardData.weatherData.timezoneOffset ?? 0
        //Card One
        ZStack {
            GeometryReader{ geometry in
                VStack{
                    background.view
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    VStack(spacing: 10) {
                        if  currentLocation {
                            Text("My Location")
                                .font(.title)
                                .bold()
                            Text(cardData.cityName )
                                .font(.title2)
                                .bold()
                        }else {
                            Text(cardData.cityName )
                                .font(.title)
                                .bold()
                        }
                        
                        Text("\(cardData.weatherData.current?.temp ?? 0, specifier: "%.0f°")")
                            .font(.system(size: 80))
                            .fontWeight(.bold)
                        Text(cardData.weatherData.current?.weather?.first?.description?.rawValue.capitalizingFirstLetterOfEachWord() ?? "Unknown")
                            .font(.title3)
                        Text("H:\(cardData.weatherData.daily?.first?.temp?.max ?? 0, specifier: "%.0f°") L:\(cardData.weatherData.daily?.first?.temp?.min ?? 0, specifier: "%.0f°")")
                            .font(.caption)
                    }
                    ZStack {
                        VStack {
                            Text(cardData.weatherData.daily?.first?.summary ?? "Loading Summary")
                                .font(.footnote)
                            CustomDivider(color: background.isDayTime ? .black : .white )
                                .padding()
                            ScrollViewReader { proxy in
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(futureHourlyForecast, id: \.dt) { hourData in
                                            VStack {
                                                Text((hourData.dt == currentTimestamp ? "Now" : hourData.dt?.toLocalTimeString(timezoneOffset: cardData.weatherData.timezoneOffset ?? 0)) ?? "N/A")
                                                    .font(.footnote)
                                                    .bold()
                                                if let iconCode = hourData.weather?.first?.icon {
                                                    WeatherIconView(iconCode: iconCode)
                                                } else {
                                                    Image(systemName: "questionmark")
                                                }
                                                Text("\(hourData.temp?.toTemperatureString() ?? "0")°")
                                                    .font(.footnote)
                                                    .bold()
                                            }
                                            .id(hourData.dt)
                                        }
                                    }
                                    .onAppear {
                                        if let currentHour = futureHourlyForecast.first(where: { $0.dt == currentTimestamp }) {
                                            proxy.scrollTo(currentHour.dt, anchor: .leading)
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                        .opacity(0.1)
                        .shadow(radius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 0)
                    )
                    
                    ZStack{
                       TenDayForecast(dailyForecast: Array(dailyForecasts), timezoneOffset: timezoneOffSet, cardData: cardData)
                            .padding()
                    }
                    .background(RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(.white)
                                            .opacity(0.1)
                                            .shadow(radius: 5))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.white, lineWidth: 0)
                                        )
                                    
                }
                .padding()
            .foregroundStyle(background.isDayTime ? .black :.white)
            }
        }
    }
    
}

extension Int {
    
    func isInFuture(comparedTo currentTime: Int) -> Bool {
        return self >= currentTime
    }
    
        func toLocalTimeString(timezoneOffset: Int) -> String {
            let localDate = Date(timeIntervalSince1970: TimeInterval(self))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ha" // Adjust format as needed
            dateFormatter.timeZone = TimeZone(secondsFromGMT: timezoneOffset)
            return dateFormatter.string(from: localDate)
        }

    func toLocalTime() -> Date {
           let date = Date(timeIntervalSince1970: TimeInterval(self))
           return date
       }
}
extension Double {
    func toTemperatureString() -> String {
        let celsiusTemp = self - 273.15
        return String(format: "%.0f", celsiusTemp)
    }
}

extension Weathernetworkmodel {
    var currentHourUnixTimestamp: Int {
        return Int(Date().timeIntervalSince1970)
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
        WeatherDetailView(cardData: mockCardData, currentLocation: true)
    }
}
