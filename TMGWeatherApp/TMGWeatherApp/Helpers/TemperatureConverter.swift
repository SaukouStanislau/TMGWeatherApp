//
//  TemperatureConverter.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

enum TemperatureUnit: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
}

struct TemperatureConverter {
    static func convertKelvinToCelcius(kelvin: Double) -> Double {
        kelvin - 273.15
    }

    static func convertKelvinToFahrenheit(kelvin: Double) -> Double {
        (kelvin - 273.15) * 9 / 5 + 32.0
    }
}
