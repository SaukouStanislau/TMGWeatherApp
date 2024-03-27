//
//  TemperatureConverter.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

struct TemperatureConverter {
    static func convertKelvinToCelcius(kelvin: Double) -> Double {
        kelvin - 273.15
    }
}
