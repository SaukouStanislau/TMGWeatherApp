//
//  DateFormatter.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 28.03.24.
//

import Foundation

struct DateToTimeFormatter {
    static func readableTime(date: Date?) -> String? {
        guard let date = date else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateToTimeFormatter.timeFormat
        return dateFormatter.string(from: date)
    }

    static var timeFormat: String {
        "HH.mm"
    }
}
