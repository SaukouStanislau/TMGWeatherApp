//
//  NetworkError.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
    case noInternet
}
