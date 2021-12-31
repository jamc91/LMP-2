//
//  Extensions.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 14/08/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

extension Date {
     func dateFormatter() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/d/yyyy"
        return formatter.string(from: self)
    }
    
    func dateFormatterForCalendar() -> String {
       let formatter = DateFormatter()
       formatter.dateFormat = "yyyy-MM-d"
       return formatter.string(from: self)
   }
}

extension String {
    
    func teamName() -> String {
        switch self {
        case "NAV":
            return "676"
        case "OBR":
            return "680"
        case "HER":
            return "677"
        case "JAL":
            return "674"
        case "CUL":
            return "678"
        case "MTY":
            return "5483"
        case "MAZ":
            return "679"
        case "MOC":
            return "675"
        case "GSV":
            return "5482"
        case "MXC":
            return "673"
        default:
            return "TBD"
        }
    }
}

extension String {
    
    func minuteFormatter() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if let stringDate = formatter.date(from: self) {
            formatter.dateFormat = "mm:ss"
            let dateString = formatter.string(from: stringDate)
            return dateString
        } else {
            return "Error"
        }
    }
}

extension KeyedDecodingContainerProtocol {
    
    func decode<T: Decodable>(
        forKey key: Key,
        default defaultExpression: @autoclosure () -> T
    ) throws -> T {
        return try decodeIfPresent(T.self, forKey: key) ?? defaultExpression()
    }
}

extension String {
    func shortName() -> String {
        switch self {
        case "Mayos de Navojoa":
            return "Mayos"
        case "Yaquis de Obregón":
            return "Yaquis"
        case "Algodoneros de Guasave":
            return "Algodoneros"
        case "Sultanes de Monterrey":
            return "Sultanes"
        case "Naranjeros de Hermosillo":
            return "Naranjeros"
        case "Charros de Jalisco":
            return "Charros"
        case "Tomateros de Culiacán":
            return "Tomateros"
        case "Cañeros de Los Mochis":
            return "Cañeros"
        case "Águilas de Mexicali":
            return "Aguilas"
        case "Venados de Mazatlán":
            return "Venados"
        default:
            return "Desconocido"
        }
    }
}
