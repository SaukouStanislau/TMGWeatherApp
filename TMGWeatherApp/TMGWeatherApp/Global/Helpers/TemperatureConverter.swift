//
//  TemperatureConverter.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

protocol ShortNamed {
    var shortName: String { get }
}

enum TemperatureUnit: String, CaseIterable, Codable {
    case celsius
    case fahrenheit
}

// MARK: - ShortNamed

extension TemperatureUnit: ShortNamed {
    var shortName: String {
        switch self {
        case .celsius:
            "°C"
        case .fahrenheit:
            "°F"
        }
    }
}

struct TemperatureConverter {
    static func convertKelvinToCelcius(kelvin: Double) -> Double {
        kelvin - 273.15
    }

    static func convertKelvinToFahrenheit(kelvin: Double) -> Double {
        (kelvin - 273.15) * 9 / 5 + 32.0
    }
}
