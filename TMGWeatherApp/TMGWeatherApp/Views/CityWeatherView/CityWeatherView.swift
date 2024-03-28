//
//  CityWeatherView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI
import Kingfisher

struct CityWeatherView: View {
    @ObservedObject var cityWeather: CityWeatherViewModel

    var body: some View {
        ZStack {
            gradientBackground.ignoresSafeArea()
            VStack {
                cityName
                temperature
                weatherStatusImage
                Spacer()
                temperatureUnitPicker
            }
        }
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

private extension CityWeatherView {
    static let weatherStatusImageSize: CGSize = CGSize(width: 200.0, height: 200.0)

    var cityName: some View {
        Text(cityWeather.city).font(.title).padding()
    }

    var temperature: some View {
        Text(cityWeather.formattedTemperature).font(.largeTitle).padding()
    }

    @ViewBuilder
    var weatherStatusImage: some View {
        if let iconImageURL = cityWeather.weatherStatusIconImageURL {
            KFImage(iconImageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: CityWeatherView.weatherStatusImageSize.height)
        }
    }

    var temperatureUnitPicker: some View {
        Menu {
            Picker("Select temperature unit", selection: $cityWeather.temperatureUnit) {
                ForEach(TemperatureUnit.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
        } label: {
            Text("\(cityWeather.temperatureUnit.rawValue) ⇳")
                .foregroundStyle(.red)
                .font(.largeTitle)
        }    }

    var gradientBackground: some View {
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
