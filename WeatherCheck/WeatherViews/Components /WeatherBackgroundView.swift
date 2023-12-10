//
//  WeatherBackgroundView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-30.
//

import SwiftUI
import AVKit

struct WeatherBackgroundView: View {
    var weatherCondition: Description
    var isDayTime: Bool
    var isFullScreen : Bool
    
    var body: some View {
        let background = determineBackground(for: weatherCondition, isDayTime: isDayTime)
        let backgroundView  =  Image(background)
        
        if isFullScreen{
            backgroundView
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        }else{
            backgroundView
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 100)
            .cornerRadius(10)
            .padding()
        }
            
    }
}

struct WeatherBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherBackgroundView(weatherCondition: .clearSky, isDayTime: false, isFullScreen: false)
        
    }
}

private func determineBackground(for condition: Description, isDayTime: Bool) -> String{
    switch condition {
    case .clearSky:
        return isDayTime ? "clearSkyDay" : "clearSkyNight"
    case .fewClouds, .scatteredClouds, .brokenClouds, .overcastClouds:
        return isDayTime ? "cloudyDay" : "cloudyNight"
    case .lightRain, .moderateRain:
        return isDayTime ? "rainDay" : "rainNight"
    case .unknown:
        return "defaultBackground"
    }
}
