//
//  WeatherService.swift
//  Weather App
//
//  Created by Rabia Dastgir on 19/01/2025.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> WeatherResponse
}
final class WeatherService: WeatherServiceProtocol {
    private let apiKey = "52e4a7b638184931b01143602251901"
    private let baseURL = "http://api.weatherapi.com/v1/current.json"
    
  func fetchWeather(for city: String) async throws -> WeatherResponse {
    
      guard let url = URL(string: "\(baseURL)?q=\(city)&key=\(apiKey)&aqi=no") else {
          throw URLError(.badURL)
      }
    
      print("Generated URL is: \(url)")
      
      let (data, response) = try await URLSession.shared.data(from: url)
      
      // Check the HTTP response status code
      if let httpResponse = response as? HTTPURLResponse {
          print("HTTP Status Code: \(httpResponse.statusCode)")
          if httpResponse.statusCode != 200 {
              print("Response indicates failure")
              throw URLError(.badServerResponse)
          }
      }
      
      // Debug: Print the raw JSON response
      if let jsonString = String(data: data, encoding: .utf8) {
          print("Raw JSON Response: \(jsonString)")
      }
      
      // Decode the data into the Weather model
      return try JSONDecoder().decode(WeatherResponse.self, from: data)
  }

}
