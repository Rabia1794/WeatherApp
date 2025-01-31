//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by Rabia Dastgir on 18/01/2025.
//

import SwiftUI
import SwiftData

@main
struct Weather_AppApp: App {
  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      Item.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()
  
  var body: some Scene {
    WindowGroup {
      let viewModel = WeatherViewModel(
        weatherService: WeatherService(),
        storageService: StorageService()
      )
      HomeView(viewModel: viewModel)
    }
    .modelContainer(sharedModelContainer)
  }
}
