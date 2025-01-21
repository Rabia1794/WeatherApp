//
//  DetailView.swift
//  Weather App
//
//  Created by Rabia Dastgir on 18/01/2025.
//

import SwiftUI

struct DetailView: View {
  var weather: WeatherResponse? // Accept the weather data
  
  var body: some View {
    VStack(spacing: 10, content: {
      
      if let fullURL = URL(string: "https:\(weather?.current.condition.icon ?? "")") {
        AsyncImage(url: fullURL) { phase in
          switch phase {
          case .empty:
            ProgressView() // Show a loading indicator
          case .success(let image):
            image
              .resizable()
              .scaledToFit()
              .frame(width: 100, height: 100) // Adjust size as needed
          case .failure:
            Image(systemName: "cloud") // Fallback image
              .resizable()
              .scaledToFit()
              .frame(width: 100, height: 100)
          @unknown default:
            EmptyView()
          }
        }
      }
      HStack{
        Text(weather?.location.name ?? "")
          .font(CustomFont.customFont(name:  CustomFont.poppinsSemiBold, size: 30))
        Image("Vector").resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
      }.padding(.horizontal, 5)
      
      HStack{
        Text(String(format: "%.1f", weather?.current.tempC ?? 0))
          .font(CustomFont.customFont(name: CustomFont.poppinsMedium, size: 70))
        Text("°")
          .font(CustomFont.customFont(name: CustomFont.poppinsRegular, size: 20)).padding(.vertical, -30)
      }
      
      
      HStack {
        VStack {
          Text("Humidity")
            .fontWeight(.regular)
            .font(CustomFont.customFont(name: CustomFont.poppinsMedium, size: 12))
            .padding(1)
            .foregroundColor(Color.init(hex: "#C4C4C4"))
          Text("\(weather?.current.humidity ?? 0)%")
            .fontWeight(.heavy)
            .font(CustomFont.customFont(name: CustomFont.poppinsMedium, size: 15))
            .foregroundColor(Color.init(hex: "#9A9A9A"))
        }
        .frame(maxWidth: .infinity) // Ensure equal width
        
        VStack {
          Text("UV")
            .fontWeight(.regular)
            .font(CustomFont.customFont(name: CustomFont.poppinsMedium, size: 12))
            .padding(1)
            .foregroundColor(Color.init(hex: "#C4C4C4"))
          Text(String(format: "%.1f", weather?.current.uv ?? 0))
            .fontWeight(.heavy)
            .font(CustomFont.customFont(name: CustomFont.poppinsMedium, size: 15))
            .foregroundColor(Color.init(hex: "#9A9A9A"))
        }
        .frame(maxWidth: .infinity) // Ensure equal width
        
        VStack {
          Text("Feels like")
            .fontWeight(.regular)
            .font(CustomFont.customFont(name: CustomFont.poppinsMedium, size: 12))
            .padding(1)
            .foregroundColor(Color.init(hex: "#C4C4C4"))
          Text(String(format: "%.1f", weather?.current.feelslikeC ?? 0) + "°")
            .fontWeight(.heavy)
            .font(CustomFont.customFont(name: CustomFont.poppinsMedium, size: 15))
            .foregroundColor(Color.init(hex: "#9A9A9A"))
        }
        .frame(maxWidth: .infinity) // Ensure equal width
      }
      .padding() // Internal padding
      .background(Color(hex: "#F2F2F2"))
      .cornerRadius(16)
      .padding(.horizontal, 50) // Margin for leading and trailing
      
    }).padding(.vertical, 50)
  }
}

#Preview {
  DetailView(weather: nil)
}


