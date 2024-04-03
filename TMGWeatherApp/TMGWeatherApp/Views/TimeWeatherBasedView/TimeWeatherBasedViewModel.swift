//
//  TimeWeatherBasedViewModel.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 2.04.24.
//

import SwiftUI

struct TimeWeatherBasedViewModel {
    let weatherInfo: WeatherInfo?

    let hoursMultipliersDictionary = [
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

    let defaultTimeMultiplier = 1.0
    let defaultWeatherMultiplier = 1.0
    let maximumBrightness: CGFloat = 1.0
    let minimumBrightness: CGFloat = 0.1

    let weatherMultipliersDictionary = [
        WeatherInfo.WeatherStatus.Status.clear : 1.0,
        WeatherInfo.WeatherStatus.Status.snow: 0.8,
        WeatherInfo.WeatherStatus.Status.clouds: 0.8,
        WeatherInfo.WeatherStatus.Status.drizzle: 0.7,
        WeatherInfo.WeatherStatus.Status.rain: 0.6,
        WeatherInfo.WeatherStatus.Status.mist: 0.5,
        WeatherInfo.WeatherStatus.Status.smoke: 0.5,
        WeatherInfo.WeatherStatus.Status.thunderstorm: 0.4
    ]

    var locationCurrentHour: Int {
        guard let location = weatherInfo?.locationName else {
            return Calendar.current.component(.hour, from: Date())
        }

        return getCurrentHourInLocation(location: location) ?? Calendar.current.component(.hour, from: Date())
    }

    func getCurrentHourInLocation(location: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: location)
        dateFormatter.dateFormat = "HH"
        
        let currentTime = Date()
        let hourString = dateFormatter.string(from: currentTime)
        
        return Int(hourString)
    }

    var brightnessMultiplier: CGFloat {
        let interval = hoursMultipliersDictionary.keys.first { $0.contains(locationCurrentHour) } ?? (0..<0)
        let timeMultiplier = hoursMultipliersDictionary[interval] ?? defaultTimeMultiplier
        let weatherMultiplier = weatherMultipliersDictionary[weatherInfo?.weather?.first?.status ?? .clear] ?? defaultWeatherMultiplier

        return timeMultiplier * 0.9 * weatherMultiplier
    }

    var topColor: Color {
        Color(red: 0.0, green: 0.0, blue: 1.0 * brightnessMultiplier)
    }

    var bottomColor: Color {
        Color(red: 0.218 * brightnessMultiplier, green: 0.833 * brightnessMultiplier, blue: 1.0 * brightnessMultiplier)
    }
}
