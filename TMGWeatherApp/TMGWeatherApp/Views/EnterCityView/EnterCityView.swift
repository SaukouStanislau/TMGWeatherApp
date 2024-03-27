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
                resultView
                Spacer()
                enterCityTextField
            }
            .background {
                gradientBackground
            }
            .navigationBarTitle("Weather", displayMode: .inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .onChange(of: cityName) { _, newValue in
                model.didTriggerChangeCity(newValue)
            }
        }
    }

    private var enterCityTextField: some View {
        TextField("Enter city name", text: $cityName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .font(.title)
            .padding()
    }

    @ViewBuilder
    private var resultView: some View {
        if let status = model.status {
            switch status {
            case .noInternet:
                noInternetMessage
            case .unknownError:
                Text("")
            case let .fetched(cityWeather):
                cityWeatherNavigationLink(for: cityWeather)
            }
        }
    }

    private var gradientBackground: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.lightBlue]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private var noInternetMessage: some View {
        Text("Can't load data due to no Internet Connection")
            .font(.body)
    }

    private func cityWeatherNavigationLink(for cityWeather: CityWeatherViewModel) -> some View {
        NavigationLink(destination: CityWeatherView(cityWeather: cityWeather)) {
            VStack {
                ShortCityWeatherView(cityWeather: cityWeather)
            }
        }
    }
}
