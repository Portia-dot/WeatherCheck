//
//  DropDownMenu.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-27.
//

import SwiftUI

struct DropDownMenu: View {
  
    var body: some View {
        VStack(alignment: .leading) {
            MenuOptionView(title: "Edit List", icon: "pencil")
            Divider()
            MenuOptionView(title: "Notifications", icon: "bell.badge")
                .padding(.bottom, 10)
            MenuOptionView(title: "Celsius", icon: "thermometer")
            Divider()
            MenuOptionView(title: "Fahrenheit", icon: "thermometer")
                .padding(.bottom, 10)
            MenuOptionView(title: "Units", icon: "ruler")
                .padding(.bottom, 10)
            MenuOptionView(title: "Report an Issue", icon: "exclamationmark.triangle")
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .frame(width: 300)
   
    }
}

struct DropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenu()
    }
}
