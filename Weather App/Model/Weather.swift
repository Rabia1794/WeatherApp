//
//  Weather.swift
//  Weather App
//
//  Created by Rabia Dastgir on 19/01/2025.
//

import Foundation

struct Weather: Decodable {
    let cityName: String
    let temperature: Double
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case main
        case weather
    }
    
    enum MainKeys: String, CodingKey {
        case temperature = "temp"
    }
    
    enum WeatherKeys: String, CodingKey {
        case description
    }
  init(cityName: String,temperature: Double,description: String ) {
    self.cityName = cityName
    self.temperature = temperature
    self.description = description
  }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try container.decode(String.self, forKey: .cityName)
        
        let mainContainer = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temperature = try mainContainer.decode(Double.self, forKey: .temperature)
        
        var weatherContainer = try container.nestedUnkeyedContainer(forKey: .weather)
        let weatherDetails = try weatherContainer.nestedContainer(keyedBy: WeatherKeys.self)
        description = try weatherDetails.decode(String.self, forKey: .description)
    }
}

import Foundation

// Top-level weather model
struct WeatherResponse: Codable {
    let location: Location
    let current: Current
}

// Location details
struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

// Current weather details
struct Current: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph: Double
    let windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMb: Double
    let pressureIn: Double
    let precipMm: Double
    let precipIn: Double
    let humidity: Int
    let cloud: Int
    let feelslikeC: Double
    let feelslikeF: Double
    let windchillC: Double
    let windchillF: Double
    let heatindexC: Double
    let heatindexF: Double
    let dewpointC: Double
    let dewpointF: Double
    let visKm: Double
    let visMiles: Double
    let uv: Double
    let gustMph: Double
    let gustKph: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case visKm = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

// Weather condition details
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}


// Air quality details
struct AirQuality: Codable {
    let co: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm25: Double
    let pm10: Double
    let usEpaIndex: Int
    let gbDefraIndex: Int

    enum CodingKeys: String, CodingKey {
        case co, no2, o3, so2
        case pm25 = "pm2_5"
        case pm10
        case usEpaIndex = "us-epa-index"
        case gbDefraIndex = "gb-defra-index"
    }
}
