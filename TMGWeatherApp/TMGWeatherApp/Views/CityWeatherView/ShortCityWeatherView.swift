//
//  ShortCityWeatherView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI

struct ShortCityWeatherView: View {
    let cityWeather: CityWeatherViewModel

    init(cityWeather: CityWeatherViewModel) {
        self.cityWeather = cityWeather
    }

    var body: some View {
        HStack {
            Text(cityWeather.city)
            Spacer()
            Text(cityWeather.formattedTemperatureInCelsius)
        }.font(.title).bold().padding()
    }
}
