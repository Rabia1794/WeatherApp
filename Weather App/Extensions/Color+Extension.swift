//
//  Color+Extension.swift
//  Weather App
//
//  Created by Rabia Dastgir on 21/01/2025.
//

import Foundation
import SwiftUI

extension Color {
  init(hex: String) {
    let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
      .replacingOccurrences(of: "#", with: "")
    let scanner = Scanner(string: hexSanitized)
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let red = Double((rgb & 0xFF0000) >> 16) / 255.0
    let green = Double((rgb & 0x00FF00) >> 8) / 255.0
    let blue = Double(rgb & 0x0000FF) / 255.0
    
    self.init(red: red, green: green, blue: blue)
  }
}
