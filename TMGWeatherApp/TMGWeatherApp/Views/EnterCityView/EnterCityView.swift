//
//  EnterCityView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI

struct EnterCityView: View {
    @ObservedObject var model: EnterCityViewModel = EnterCityViewModel(weatherService: OpenWeatherMapService())
    @State var cityName: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                TextField("Enter city name", text: $cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding()
                if let cityWeather = model.cityWeather {
                    NavigationLink(destination: CityWeatherView(cityWeather: cityWeather)) {
                        VStack {
                            Text("Click to see detailed weather")
                            CityWeatherView(cityWeather: cityWeather)
                        }
                    }
                }
                Spacer()
            }.onChange(of: cityName) { _, newValue in
                model.didTriggerChangeCity(newValue)
            }
            .navigationBarTitle("Weather", displayMode: .inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
