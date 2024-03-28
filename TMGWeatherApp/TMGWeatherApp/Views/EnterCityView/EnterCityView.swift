//
//  EnterCityView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI

struct EnterCityView: View {
    @ObservedObject var model: EnterCityViewModel
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
            case .noCity:
                noCityMessage
            case .unknownError:
                somethingWentWrongMessage
            case let .fetched(cityWeather):
                cityWeatherNavigationLink(for: cityWeather)
            case .processing:
                progressView
            }
        }
    }

    // In the future this could be changed to show gradient depending on weather in city (dark color for night and bad weather, light - for day and good)

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

    private var noCityMessage: some View {
        Text("Can't find data, check if your city name is correct")
            .font(.body)
    }

    private var somethingWentWrongMessage: some View {
        Text("Something went wrong, please try again")
            .font(.body)
    }

    private var progressView: some View {
        ProgressView()
            .controlSize(.large)
    }

    private func cityWeatherNavigationLink(for cityWeather: CityWeatherViewModel) -> some View {
        NavigationLink(destination: CityWeatherView(cityWeather: cityWeather)) {
            VStack {
                ShortCityWeatherView(cityWeather: cityWeather)
            }
        }
    }
}

#Preview {
    EnterCityView(model: EnterCityViewModel(weatherService: OpenMapFetchWeatherInfoService()))
}
