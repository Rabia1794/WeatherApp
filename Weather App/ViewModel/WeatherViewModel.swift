//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Rabia Dastgir on 19/01/2025.
//

import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var city: String? = ""
    @Published var errorMessage: String?
    
    private let weatherService: WeatherServiceProtocol
    private let storageService: StorageServiceProtocol
    
    init(weatherService: WeatherServiceProtocol, storageService: StorageServiceProtocol) {
        self.weatherService = weatherService
        self.storageService = storageService
        loadSavedCity()
    }
    
    func fetchWeather() async {
        do {
            let fetchedWeather = try await weatherService.fetchWeather(for: city ?? "")
          print("fetchedWeather is: ", fetchedWeather)

            weather = fetchedWeather
            saveCity()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func saveCity() {
        storageService.saveCity(city ?? "")
    }
    
    private func loadSavedCity() {
        city = storageService.loadCity() ?? ""
    }
}
