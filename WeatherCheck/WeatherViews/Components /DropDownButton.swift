//
//  SwiftUIView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-27.
//

import SwiftUI

struct DropDownButton: View {
    @State private var showDropDown = false
    var body: some View {
        HStack{
            Spacer()
            VStack{
                Button {
                    withAnimation{
                        showDropDown.toggle()
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDropDown ? 90 : 0))
                        .foregroundColor(.secondary)
                }
                .padding()
                .popover(isPresented: $showDropDown, arrowEdge: .top) {
                    DropDownMenu()
                        .frame(minWidth: 300, maxHeight: 400)
                        .presentationCompactAdaptation(.popover)
                }

            }
        }
    }
}

struct DropDownButton_Previews: PreviewProvider {
    static var previews: some View {
        DropDownButton()
    }
}
