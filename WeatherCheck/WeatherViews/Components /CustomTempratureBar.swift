//
//  CustomTempratureBar.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-12-17.
//

import SwiftUI

struct CustomTempratureBar: View {
    var dayMinTemperature: Double
    var dayMaxTemperature: Double
    var fullRangeMinTemperature: Double
    var fullRangeMaxTemperature: Double
    
    
    var body: some View {
        GeometryReader{ geometry in
            
            let totalWidth = geometry.size.width
            let dayRange = dayMaxTemperature - dayMinTemperature
            let fullRange = fullRangeMaxTemperature - fullRangeMinTemperature
            let offset = (dayMinTemperature - fullRangeMinTemperature) / fullRange * totalWidth
            let fillWidth = dayRange / fullRange * totalWidth
            let averageTemperature = (dayMinTemperature + dayMaxTemperature) / 2
            
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: totalWidth, height: 10)
                
                Rectangle()
                    .fill(temperatureColor(for: averageTemperature)) 
                    .frame(width: fillWidth, height: 10)
                    .offset(x: offset)
            }
        }
        .cornerRadius(2.5)
        .frame(height: 5)
        .padding()
    }
    
    func temperatureColor(for temperature: Double) -> Color {
        switch temperature {
        case ..<0:
            return TemperatureColors.darkBlue
        case 0..<15:
            return TemperatureColors.lightBlue
        case 15..<20:
            return TemperatureColors.green
        case 20..<25:
            return TemperatureColors.yellow
        case 25..<30:
            return TemperatureColors.orange
        default:
            return TemperatureColors.red
        }
    }
    
}

struct CustomTempratureBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTempratureBar(dayMinTemperature: -10, dayMaxTemperature: -2, fullRangeMinTemperature: -20, fullRangeMaxTemperature: -1)
    }
}


struct TemperatureColors {
    static let darkBlue = Color.blue
    static let lightBlue = Color.blue.opacity(0.5)
    static let green = Color.green
    static let yellow = Color.yellow
    static let orange = Color.orange
    static let red = Color.red
}
