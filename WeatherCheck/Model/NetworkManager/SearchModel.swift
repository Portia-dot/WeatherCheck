//
//  SearchViewModel.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-30.
//

import Foundation

// MARK: - SearchModelElement
struct SearchModelElement: Decodable, Identifiable {
    var id = UUID()
    let name: String?
    let localNames: [String: String]?
    let lat, lon: Double
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name, localNames = "local_names", lat, lon, country, state
    }
}
