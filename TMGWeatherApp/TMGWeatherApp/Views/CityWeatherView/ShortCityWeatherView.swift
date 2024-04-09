//
//  ShortCityWeatherView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI

struct ShortCityWeatherView: View {
    let cityWeather: CityWeatherViewModel

    // This State added to refresh view on appear in case there were changes of how to show properties
    @State private var refresh: Bool = false

    var body: some View {
        HStack {
            cityName
            Spacer()
            temperature
        }.background {
            backgroundView
        }.onAppear {
            refresh.toggle()
        }
        .background(Color.clear.disabled(refresh))
        .font(.largeTitle)
        .foregroundStyle(.white)
        .bold()
        .padding()
    }
}

// MARK: - Private

private extension ShortCityWeatherView {
    var cityName: some View {
        Text(cityWeather.cityName).padding()
    }

    var temperature: some View {
        Text(cityWeather.formattedTemperature).padding()
    }

    var backgroundView: some View {
        RoundedRectangle(cornerRadius: ShortCityWeatherView.Constants.backgroundViewCornerRadius
        )
            .foregroundStyle(Material.thin)
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
        weatherInfo: WeatherInfo.previewWeatherInfo, 
        weatherService: OpenMapFetchWeatherInfoService(),
        weatherIconsService: OpenMapWeatherIconsService(),
        settingsStorage: SettingsStorage(),
        favouritesService: FetchFavouritesService(favouriteStorage: FavouriteStorage())
    )
    return ShortCityWeatherView(cityWeather: cityWeather)
}
