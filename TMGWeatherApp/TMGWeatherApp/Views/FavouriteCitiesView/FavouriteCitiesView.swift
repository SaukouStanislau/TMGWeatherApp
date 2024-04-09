//
//  FavouriteCitiesView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 9.04.24.
//

import SwiftUI

struct FavouriteCitiesView: View {
    @ObservedObject var viewModel: FavouriteCitiesViewModel

    var body: some View {
        cities.onAppear {
            viewModel.viewDidTriggerAppear()
        }
    }
}

// MARK: - Private

private extension FavouriteCitiesView {
    var cities: some View {
        VStack {
            ScrollView {
                ForEach(Array(viewModel.citiesWeather.keys), id: \.self) { city in
                    if let weatherInfo = viewModel.citiesWeather[city] {
                        let cityWeather = CityWeatherViewModel(
                            weatherInfo: weatherInfo,
                            weatherService: OpenMapFetchWeatherInfoService(),
                            weatherIconsService: OpenMapWeatherIconsService(),
                            settingsStorage: SettingsStorage(),
                            favouritesService: FetchFavouritesService(favouriteStorage: FavouriteStorage())
                        )
                        NavigationLink(destination: CityWeatherView(cityWeather: cityWeather)) {
                            ShortCityWeatherView(cityWeather: cityWeather)
                        }
                    }
                }
            }
        }
    }
}
