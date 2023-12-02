//
//  WeatherCheckApp.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-24.
//

import SwiftUI

@main
struct WeatherCheckApp: App {


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(WeatherViewModel())
        }
    }
}
