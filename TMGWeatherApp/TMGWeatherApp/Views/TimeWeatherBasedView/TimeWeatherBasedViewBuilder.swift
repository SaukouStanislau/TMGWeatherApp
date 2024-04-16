//
//  TimeWeatherBasedViewBuilder.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 16.04.24.
//

struct TimeWeatherBasedViewBuilder {
    static func timeWeatherBasedView(for weatherInfo: WeatherInfo?) -> TimeWeatherBasedView {
        let viewModel = TimeWeatherBasedViewModel(weatherInfo: weatherInfo)
        return TimeWeatherBasedView(viewModel: viewModel)
    }
}
