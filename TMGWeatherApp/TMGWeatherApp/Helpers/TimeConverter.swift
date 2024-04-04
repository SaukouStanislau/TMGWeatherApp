//
//  TimeConverter.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 4.04.24.
//

import Foundation

struct TimeConverter {
    static func getCurrentHoursInLocation(_ location: String) -> Int? {
        guard
            let knownTimeZoneIdentifier = TimeZone.knownTimeZoneIdentifiers.first(where: { $0.contains(location.timeZoneIdentifierFormat) }),
            let timeZone = TimeZone(identifier: knownTimeZoneIdentifier)
        else {
            return nil
        }

        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = timeZone
        return calendar.component(.hour, from: Date())
    }
}

extension String {
    var timeZoneIdentifierFormat: String {
        self.replacingOccurrences(of: " ", with: "_")
    }
}
