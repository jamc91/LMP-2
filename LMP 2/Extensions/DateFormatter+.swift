//
//  DateFormatter+.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 14/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

extension Formatter {
    static func formatterDate(from decoder: Decoder) throws -> Date {
        let container = try decoder.singleValueContainer()
        let stringDate = try container.decode(String.self)
        
        if let date = DateFormatter.iso8601.date(from: stringDate) ?? DateFormatter.iso8601Full.date(from: stringDate) ?? DateFormatter.dateCalendarApiLMP.date(from: stringDate) {
            return date
        } else {
            return Date()
        }
    }
    
    static let iso8601Full: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()
    
    static let dateCalendarApiLMP: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = .current
        return formatter
    }()
}

extension Date {
    var dayOfWeekAndTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E HH:mm"
        formatter.timeZone = TimeZone(identifier: "PST")
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let output = formatter.string(from: self)
        return output.uppercased()
    }
    
    var timePM: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let output = formatter.string(from: self)
        return output.uppercased()
    }
    
    var dayAndMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d MMMM"
        let output = formatter.string(from: self)
        return output.uppercased()
    }
}
