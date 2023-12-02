//
//  MenuOptionView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-27.
//

import SwiftUI

struct MenuOptionView: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack{
            Text(title)
                Spacer()
            Image(systemName: icon)
        }
    }
}

struct MenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        MenuOptionView(title: "Edit List", icon: "pencil")
    }
}
