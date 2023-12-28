//
//  WeatherIconView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-12-10.
//

import SwiftUI
import SwiftUI

struct WeatherIconView: View {
    let iconCode: String

    var body: some View {
        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")) { phase in
            if let image = phase.image {
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            } else if phase.error != nil {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            } else {
                ProgressView()
            }
        }
    }
}

    struct WeatherIconView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherIconView(iconCode: "10d")
        }
    }
