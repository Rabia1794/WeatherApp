//
//  ContentView.swift
//  Weather App
//
//  Created by Rabia Dastgir on 18/01/2025.
//

import SwiftUI

struct HomeView: View {
  @State private var searchText = ""
  @State private var showCard = false // To toggle the card visibility
  @State private var showDetailView = false
  @StateObject private var viewModel: WeatherViewModel
  @State private var weather: WeatherResponse?
  
  init(viewModel: WeatherViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    VStack {
      // Search bar
      HStack {
        TextField("Search Location", text: $searchText)
          .onChange(of: searchText, { oldValue, newValue in
            if newValue.count > 1 { //if character count is greater than 1 then show suggestion
              viewModel.city = searchText
              searchPlace()
            }
          })
          .font(CustomFont.customFont(name: CustomFont.poppinsRegular, size: 15))
          .padding(10)
          .background(Color(hex: "#F2F2F2"))
          .cornerRadius(15)
          .overlay(
            HStack {
              Spacer()
              Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.trailing, 10)
            }
          )
      }
      .padding(.horizontal, 16)
      .padding(.top, 20)
      
      // Card view to display search results
      if showCard {
        CardView
      } else if showDetailView {
        // Pass the weather data to the DetailView
        DetailView(weather: viewModel.weather)
          .transition(.slide)
          .padding(.horizontal, 16)
          .padding(.top, 16)
      } else {
        Spacer()
        EmptyCityView()
      }
      Spacer()
    }
    .background(Color(UIColor.systemBackground))
    .animation(.easeOut, value: showDetailView)
    .onAppear {
      if let city = viewModel.city, !city.isEmpty {
        fetchPlaceDetail()
      }
    }
  }
  
  var CardView: some View {
    Group {
      if let weather = viewModel.weather {
        HStack(alignment: .top, spacing: 0) {
          // Text content
          VStack(alignment: .leading, spacing: 10) {
            Text(weather.location.name)
              .font(CustomFont.customFont(name: CustomFont.poppinsSemiBold, size: 30))
            
            HStack{
              Text("\(weather.current.tempC, specifier: "%.1f")")
                .font(CustomFont.customFont(name: CustomFont.poppinsMedium, size: 60))
                .foregroundColor(.black)
              Text("°")
                .font(CustomFont.customFont(name: CustomFont.poppinsRegular, size: 20)).padding(.vertical, -30)
            }
          }
          Spacer()
          if let fullURL = URL(string: "https:\(weather.current.condition.icon)") {
            AsyncImage(url: fullURL) { phase in
              switch phase {
              case .empty:
                ProgressView() // Show a loading indicator
              case .success(let image):
                image
                  .resizable()
                  .scaledToFit()
                  .frame(width: 100, height: 100)
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
        }
        .padding()
        .background(Color(hex: "#F2F2F2"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .onTapGesture {
          searchText = ""
          showCard = false
          showDetailView = true
          viewModel.saveCity()
        }
      } else if let errorMessage = viewModel.errorMessage {
        Text(errorMessage)
          .foregroundColor(.red)
          .padding()
      } else {
        Text("")
      }
    }
  }
  
  
  func EmptyCityView() -> some View {
    VStack {
      Text("No City Selected")
        .font(CustomFont.customFont(name: CustomFont.poppinsSemiBold, size: 30))
        .padding(.bottom, 5)
        .foregroundColor(.black)
      
      Text("Please Search For A City")
        .font(CustomFont.customFont(name: CustomFont.poppinsSemiBold, size: 15))
        .foregroundColor(.black)
    }
  }
  
  
  
  //MARK: - SEARCH PLACE
  func searchPlace() {
    Task {
      await viewModel.fetchWeather()
      showCard = true
      showDetailView = false
    }
  }
  
  func fetchPlaceDetail() {
    Task {
      await viewModel.fetchWeather()
      showCard = false
      showDetailView = true
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = WeatherViewModel(
      weatherService: WeatherService(),
      storageService: StorageService()
    )
    return HomeView(viewModel: viewModel)
  }
}
