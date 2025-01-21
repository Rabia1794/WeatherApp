//
//  StorageService.swift
//  Weather App
//
//  Created by Rabia Dastgir on 19/01/2025.
//

import Foundation

protocol StorageServiceProtocol {
    func saveCity(_ city: String)
    func loadCity() -> String?
}

final class StorageService: StorageServiceProtocol {
    private let cityKey = "SavedCity"
    
    func saveCity(_ city: String) {
      //using userdefaults because we only need to save search string, so we can load api to show fresh data as saved city
        UserDefaults.standard.set(city, forKey: cityKey)
    }
    
    func loadCity() -> String? {
        UserDefaults.standard.string(forKey: cityKey)
    }
}
