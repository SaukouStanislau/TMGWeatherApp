//
//  TMGDecodingWeatherInfoTests.swift
//  TMGWeatherAppTests
//
//  Created by Stanislau Saukou on 27.03.24.
//

import XCTest
@testable import TMGWeatherApp

final class TMGDecodingWeatherInfoTests: XCTestCase {
    func testWeatherStatusDecodingSuccess()  throws {
        let jsonWithWeatherStatus = """
            {
                "weather": [
                    {
                        "description": "clear sky",
                        "main": "Clear"
                    }
                ]
            }
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let weatherInfo = try decoder.decode(WeatherInfo.self, from: jsonWithWeatherStatus)

        XCTAssertEqual(weatherInfo.weather?.first?.description, "clear sky")
        XCTAssertEqual(weatherInfo.weather?.first?.status, "Clear")
    }

    func testTemperatureDecodingSuccess()  throws {
        let jsonWithTemperature = """
            {
                "main": {
                    "temp": 286.77
                }
            }
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let weatherInfo = try decoder.decode(WeatherInfo.self, from: jsonWithTemperature)

        XCTAssertEqual(weatherInfo.temperatureInfo?.temperature, 286.77)
    }
}
