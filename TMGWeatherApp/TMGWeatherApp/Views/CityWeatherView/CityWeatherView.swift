//
//  CityWeatherView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI
import Kingfisher

struct CityWeatherView: View {
    static let weatherStatusImageSize: CGSize = CGSize(width: 200.0, height: 200.0)
    let cityWeather: CityWeatherViewModel

    var body: some View {
        ZStack {
            gradientBackground.ignoresSafeArea()
            VStack {
                cityName
                temperature
                weatherStatusImage
                Spacer()
            }
        }
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
    }

    private var cityName: some View {
        Text(cityWeather.city).font(.title).padding()
    }

    private var temperature: some View {
        Text(cityWeather.formattedTemperatureInCelsius).font(.largeTitle).padding()
    }

    @ViewBuilder
    private var weatherStatusImage: some View {
        if let iconImageURL = cityWeather.weatherStatusIconImageURL {
            KFImage(iconImageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: CityWeatherView.weatherStatusImageSize.height)
        }
    }

    private var gradientBackground: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.lightBlue]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview {
    let cityWeather = CityWeatherViewModel(
        city: "Warsaw",
        weatherInfo: WeatherInfo.previewWeatherInfo, 
        weatherIconsService: OpenMapWeatherIconsService()
    )
    return CityWeatherView(cityWeather: cityWeather)
}
