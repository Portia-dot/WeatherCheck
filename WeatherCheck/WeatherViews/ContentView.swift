//
//  ContentView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-24.


import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
      WeatherHomeCardStack()
            .environmentObject(WeatherViewModel())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//
//  ContentView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-24.
//

//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    @State var searchText = ""
//    @State private var isSearchBarFocused = false
//    var body: some View {
//        WeatherSearchView(searchText: $searchText, isSearchBarFocused: $isSearchBarFocused)
//            .environmentObject(WeatherViewModel())
//    }
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
