//
//  WeatherHomeView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-24.
//

import SwiftUI

struct WeatherHomeView: View {
    var body: some View {
        ScrollView {
                    LazyVStack(pinnedViews:[.sectionHeaders]) {
                        
                        Circle()
                        
                        
                        Section(header:
                                    HStack {
                            Rectangle()
                                .frame(height: 50)
                                .padding()
                            Rectangle()
                                .frame(height: 50)
                                .padding()
                            Rectangle()
                                .frame(height: 50)
                                .padding()
                            
                        }) {
                            ForEach(0..<20) { index in
                                VStack {
                                    Image(systemName: "globe")
                                        .imageScale(.large)
                                        .foregroundColor(.accentColor)
                                    Text("Hello, world!")
                                }
                                .padding()
                            }
                        }
                    }
                    .padding()
                }
    }
}

struct WeatherHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherHomeView()
    }
}
