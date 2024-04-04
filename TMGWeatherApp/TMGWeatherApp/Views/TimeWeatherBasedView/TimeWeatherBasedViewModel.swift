//
//  TimeWeatherBasedViewModel.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 2.04.24.
//

import SwiftUI

struct TimeWeatherBasedViewModel {
    let weatherInfo: WeatherInfo?

    var currentHour: Int {
        currentHourInLocation ?? Calendar.current.component(.hour, from: Date())
    }

    var currentHourInLocation: Int? {
        guard let locationName = weatherInfo?.locationName else {
            return nil
        }

        return TimeConverter.getCurrentHoursInLocation(locationName) ?? nil
    }

    var brightnessMultiplier: CGFloat {
        let interval = Constants.hoursMultipliersDictionary.keys.first { $0.contains(currentHour) } ?? (0..<0)
        let timeMultiplier = Constants.hoursMultipliersDictionary[interval] ?? Constants.defaultTimeMultiplier
        let weatherMultiplier = Constants.weatherMultipliersDictionary[weatherInfo?.weather?.first?.status ?? .clear] ?? Constants.defaultWeatherMultiplier

        return timeMultiplier * 0.9 * weatherMultiplier
    }

    var topColor: Color {
        Color(red: 0.0, green: 0.0, blue: 1.0 * brightnessMultiplier)
    }

    var bottomColor: Color {
        Color(red: 0.218 * brightnessMultiplier, green: 0.833 * brightnessMultiplier, blue: 1.0 * brightnessMultiplier)
    }
}

private extension TimeWeatherBasedViewModel {
    struct Constants {
        static let defaultTimeMultiplier = 1.0
        static let defaultWeatherMultiplier = 1.0
        static let maximumBrightness: CGFloat = 1.0
        static let minimumBrightness: CGFloat = 0.1

        static let hoursMultipliersDictionary = [
            (0..<5): 0.1,
            (5..<6): 0.2,
            (6..<7): 0.5,
            (8..<10): 0.7,
            (10..<12): 0.8,
            (12..<17): 1.0,
            (17..<18): 0.8,
            (18..<19): 0.7,
            (19..<21): 0.4,
            (21..<22): 0.2,
            (23..<24): 0.1,
        ]

        static let weatherMultipliersDictionary = [
            WeatherInfo.WeatherStatus.Status.clear : 1.0,
            WeatherInfo.WeatherStatus.Status.snow: 0.8,
            WeatherInfo.WeatherStatus.Status.clouds: 0.8,
            WeatherInfo.WeatherStatus.Status.drizzle: 0.7,
            WeatherInfo.WeatherStatus.Status.rain: 0.6,
            WeatherInfo.WeatherStatus.Status.mist: 0.5,
            WeatherInfo.WeatherStatus.Status.smoke: 0.5,
            WeatherInfo.WeatherStatus.Status.thunderstorm: 0.4
        ]
    }
}
