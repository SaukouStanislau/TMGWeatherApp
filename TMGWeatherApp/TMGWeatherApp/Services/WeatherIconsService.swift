//
//  WeatherIconsService.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 28.03.24.
//

protocol WeatherIconsService {
    func getIconStringURLForWeatherStatus(_ weatherStatus: WeatherInfo.WeatherStatus) -> String?
}

final class OpenMapWeatherIconsService: WeatherIconsService {
    func getIconStringURLForWeatherStatus(_ weatherStatus: WeatherInfo.WeatherStatus) -> String? {
        guard let icon = weatherStatus.icon else {
            return nil
        }

        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
}
