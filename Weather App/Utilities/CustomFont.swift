//
//  CustomFont.swift
//  Weather App
//
//  Created by Rabia Dastgir on 21/01/2025.
//

import Foundation
import SwiftUI

struct CustomFont {
  static let poppinsSemiBold = "Poppins-SemiBold"
  static let poppinsMedium = "Poppins-Medium"
  static let poppinsRegular = "Poppins-Regular"
  
  // You can add more fonts here
  
  static func customFont(name: String, size: CGFloat) -> Font {
    return .custom(name, size: size)
  }
  
  // If you need a system font option, you can add it as well
  static func systemFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
    return .system(size: size, weight: weight)
  }
}
