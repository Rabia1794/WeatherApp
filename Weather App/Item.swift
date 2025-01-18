//
//  Item.swift
//  Weather App
//
//  Created by Rabia Dastgir on 18/01/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
