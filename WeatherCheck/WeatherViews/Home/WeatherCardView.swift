//
//  WeatherCardView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-12-01.
//
//import SwiftUI
//
//struct WeatherCardView: View {
//    var weatherData: Weathernetworkmodel
//
//    var body: some View {
//        ZStack {
//            backgroundView()
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color.clear)
//                .overlay(
//                    VStack(alignment: .leading) {
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(weatherData.timezone ?? "Unknown Location")
//                                    .font(.subheadline)
//                                    .fontWeight(.black)
//                                Text(formatUnixTimeStamp(weatherData.current?.dt ?? 0, timezone: weatherData.timezone ?? "UTC"))
//                                    .font(.footnote)
//                                    .fontWeight(.bold)
//                            }
//                            Spacer()
//                            Text("\(weatherData.current?.temp ?? 0, specifier: "%.0f")°")
//                                .font(.title)
//                                .fontWeight(.black)
//                        }
//                        .padding()
//                        HStack {
//                            Text(weatherData.current?.weather?.first?.description?.rawValue.capitalizingFirstLetterOfEachWord() ?? "Unknown")
//                                .font(.footnote)
//                                .fontWeight(.bold)
//                            Spacer()
//                            Text("H:\(weatherData.daily?.first?.temp?.max ?? 0, specifier: "%.0f°") L:\(weatherData.daily?.first?.temp?.min ?? 0, specifier: "%.0f°")")
//                                .font(.footnote)
//                                .fontWeight(.bold)
//                        }
//                        .padding()
//                    }
//                    .padding()
//                )
//                .frame(maxWidth: .infinity)
//                .padding(.horizontal)
//        }
//    }
//
//    private func backgroundView() -> some View {
//        // Replace with your background view logic
//        Color.blue
//    }
//
//    private func formatUnixTimeStamp(_ timestamp: Int, timezone: String) -> String {
//        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        formatter.dateStyle = .none
//        formatter.timeZone = TimeZone(identifier: timezone)
//        return formatter.string(from: date)
//    }
//}
//
////extension String {
////    func capitalizingFirstLetterOfEachWord() -> String {
////        return self.lowercased().split(separator: " ").map { $0.capitalized }.joined(separator: " ")
////    }
////}
//
//// Usage Example
//// WeatherHomeCard(weatherData: someWeathernetworkmodelInstance)
//
//struct WeatherCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherHomeCard()
//    }
//}
//
