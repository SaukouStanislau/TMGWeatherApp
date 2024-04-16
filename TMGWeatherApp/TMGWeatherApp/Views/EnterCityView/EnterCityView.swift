//
//  EnterCityView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI

struct EnterCityView: View {
    @ObservedObject var viewModel: EnterCityViewModel
    @State var cityName: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                resultView
                Spacer()
                enterCityTextField
            }
            .background {
                gradientBackground.ignoresSafeArea()
            }
            .navigationBarTitle("Weather", displayMode: .inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    settingsLink
                }
            }
            .onChange(of: cityName) { _, newValue in
                viewModel.didTriggerChangeCity(newValue)
            }
        }
    }
}

// MARK: - Private

private extension EnterCityView {
    var enterCityTextField: some View {
        TextField("Enter city name", text: $cityName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .font(.title)
            .padding()
    }

    @ViewBuilder
    var resultView: some View {
        switch viewModel.status {
        case .noInternet:
            errorView(errorText: "Can't load data due to no Internet Connection")
        case .noCity:
            errorView(errorText: "Can't find data, check if your city name is correct")
        case .unknownError:
            errorView(errorText: "Something went wrong, please try again")
        case let .fetched(cityWeather):
            cityWeatherNavigationLink(for: cityWeather)
        case .processing:
            progressView
        case .empty:
            favouritesView
        }
    }

    var favouritesView: some View {
        FavouriteCitiesViewBuilder.favouriteCitiesView
    }

    // In the future this could be changed to show gradient depending on weather in city (dark color for night and bad weather, light - for day and good)

    @ViewBuilder
    var gradientBackground: some View {
        TimeWeatherBasedViewBuilder.timeWeatherBasedView(for: viewModel.weatherInfo)
    }

    func errorView(errorText: String) -> some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
            Text(errorText)
                .font(.title)
                .multilineTextAlignment(.center)
        }
    }

    var progressView: some View {
        ProgressView()
            .controlSize(.large)
    }

    var settingsLink: some View {
        NavigationLink(destination: SettingsViewBuilder.settingsView) {
            Image(systemName: "gearshape")
        }
    }

    func cityWeatherNavigationLink(for cityWeather: CityWeatherViewModel) -> some View {
        NavigationLink(destination: CityWeatherView(cityWeather: cityWeather)) {
            ShortCityWeatherView(cityWeather: cityWeather)
        }
    }
}

#Preview {
    EnterCityViewBuilder.enterCityView
}
