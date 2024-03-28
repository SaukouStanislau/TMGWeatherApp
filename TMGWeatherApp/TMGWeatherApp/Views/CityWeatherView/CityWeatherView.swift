//
//  CityWeatherView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI

struct CityWeatherView: View {
    let cityWeather: CityWeatherViewModel

    var body: some View {
        ZStack {
            gradientBackground.ignoresSafeArea()
            VStack {
                cityName
                temperature
                Spacer()
            }
        }
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
    }

    private var cityName: some View {
        Text(cityWeather.city).font(.title).padding()
    }

    private var temperature: some View {
        Text(cityWeather.formattedTemperatureInCelsius).font(.largeTitle).padding()
    }

    private var gradientBackground: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.lightBlue]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview {
    let cityWeather = CityWeatherViewModel(
        city: "Warsaw",
        weatherInfo: WeatherInfo.previewWeatherInfo
    )
    return CityWeatherView(cityWeather: cityWeather)
}
