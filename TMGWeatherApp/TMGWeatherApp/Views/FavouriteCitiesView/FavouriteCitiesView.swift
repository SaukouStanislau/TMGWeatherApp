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
        VStack {
            title
            cities
        }
        .onAppear {
            viewModel.viewDidTriggerAppear()
        }
    }
}

// MARK: - Private

#warning("Order of Cities")

private extension FavouriteCitiesView {
    var title: some View {
        HStack {
            Text("Favourites")
                .bold()
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
            Spacer()
        }
    }

    var cities: some View {
        ScrollView {
            ForEach(Array(viewModel.citiesWeather.keys), id: \.self) { city in
                if let weatherInfo = viewModel.citiesWeather[city] {
                    NavigationLink(destination: CityWeatherViewBuilder.cityWeatherView(for: weatherInfo)) {
                        CityWeatherViewBuilder.shortCityWeatherView(for: weatherInfo)
                    }
                }
            }
        }
    }
}
