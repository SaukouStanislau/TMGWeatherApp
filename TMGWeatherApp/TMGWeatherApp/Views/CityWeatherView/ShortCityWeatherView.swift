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
            backgroundView
        }.font(.largeTitle).bold().padding()
    }
}

// MARK: - Private

private extension ShortCityWeatherView {
    var cityName: some View {
        Text(cityWeather.city).padding()
    }

    var temperature: some View {
        Text(cityWeather.formattedTemperature).padding()
    }

    var backgroundView: some View {
        RoundedRectangle(cornerRadius: ShortCityWeatherView.Constants.backgroundViewCornerRadius)
            .foregroundStyle(Material.regular)
            .opacity(ShortCityWeatherView.Constants.backgroundViewOpacity)
    }
}

// MARK: - Constants

private extension ShortCityWeatherView {
    struct Constants {
        static let backgroundViewCornerRadius: CGFloat = 20.0
        static let backgroundViewOpacity: CGFloat = 0.4

    }
}

#Preview {
    let cityWeather = CityWeatherViewModel(
        city: "Warsaw",
        weatherInfo: WeatherInfo.previewWeatherInfo, 
        weatherService: OpenMapFetchWeatherInfoService(),
        weatherIconsService: OpenMapWeatherIconsService()
    )
    return ShortCityWeatherView(cityWeather: cityWeather)
}
