//
//  Debouncer.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-30.
//

import Foundation


class Debouncer{
    private var workItem: DispatchWorkItem?
    private var interval: TimeInterval
    
    init(interval: TimeInterval) {
        self.interval = interval
    }
    
    func debounce(action: @escaping () -> Void){
        workItem?.cancel()
        workItem = DispatchWorkItem(block: action)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: workItem!)
    }
}
