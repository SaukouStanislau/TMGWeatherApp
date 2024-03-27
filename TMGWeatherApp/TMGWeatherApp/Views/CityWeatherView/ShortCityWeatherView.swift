//
//  ShortCityWeatherView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI

struct ShortCityWeatherView: View {
    let cityWeather: CityWeatherViewModel

    var body: some View {
        HStack {
            cityName
            Spacer()
            temperature
        }.background {
            RoundedRectangle(cornerRadius: 20.0).foregroundStyle(Color.gray)
        }.font(.title).bold().padding()
    }

    private var cityName: some View {
        Text(cityWeather.city).padding()
    }

    private var temperature: some View {
        Text(cityWeather.formattedTemperatureInCelsius).padding()
    }
}
