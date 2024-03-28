//
//  ShortCityWeatherView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI

struct ShortCityWeatherView: View {
    static let backgroundViewCornerRadius: CGFloat = 20.0
    static let backgroundViewOpacity: CGFloat = 0.4

    let cityWeather: CityWeatherViewModel

    var body: some View {
        HStack {
            cityName
            Spacer()
            temperature
        }.background {
            backgroundView
        }.font(.largeTitle).bold().padding()
    }

    private var cityName: some View {
        Text(cityWeather.city).padding()
    }

    private var temperature: some View {
        Text(cityWeather.formattedTemperatureInCelsius).padding()
    }

    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: ShortCityWeatherView.backgroundViewCornerRadius)
            .foregroundStyle(Color.gray)
            .opacity(ShortCityWeatherView.backgroundViewOpacity)
    }
}
