//
//  CustomDivider.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-12-16.
//

import SwiftUI

struct CustomDivider: View {
    var color : Color
    var width: CGFloat = 1
    var horizontalPadding: CGFloat = 0
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .padding(.horizontal, horizontalPadding)
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider(color: .black, width: 2, horizontalPadding: 3)
                    .previewLayout(.sizeThatFits) // Layout to fit the divider size
                    .padding()
    }
}
