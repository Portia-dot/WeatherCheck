//
//  WeatherCheckApp.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-24.
//

import SwiftUI

@main
struct WeatherCheckApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
