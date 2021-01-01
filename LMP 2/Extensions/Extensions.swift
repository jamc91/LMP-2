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
}


extension URL {
    static func apiURL(_ link: String) -> URL {
        URL(string: "https://statsapi.mlb.com\(link)")!
    }
    
    static func gamesLink(date: String) -> URL {
        URL(string: "https://statsapi.mlb.com/api/v1/schedule?language=es&leagueId=103,104,132&sportId=1,17&date=\(date)&sortBy=gameStatus&sortBy=gameDate&hydrate=team,linescore(matchup,runners),person,stats,probablePitcher,decisions")!
    }
    
    static var standingLMPLink: URL {
        URL(string: "https://api.lmp.mx/3.0.0/standing")!
    }
    
    static var standingMLBLink: URL {
        URL(string: "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&standingsTypes=regularSeason&hydrate=division,team")!
    }
    
    static func leaders(mode: String, season: String, category: String, order: String) -> URL {
        URL(string: "https://api.lmp.mx/3.0.0/leaders?mode=\(mode)&type=\(season)&column=\(category)&order=\(order)")!
    }
    
    static func imageURL(image: Int) -> URL {
       return URL(string: "https://content.mlb.com/images/headshots/current/60x60/\(image)@2x.png")!
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
    
    func hourFormat(status: Bool) -> String {
        
        if status {
            return "Time TBD"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            formatter.timeZone = .current
            formatter.locale = Locale(identifier: "en_US_POSIX")
            if let hour = formatter.date(from: self) {
                formatter.dateFormat = "h:mm a"
                let dateString = formatter.string(from: hour)
                return dateString
            }
            return ""
        }
    }
}

extension KeyedDecodingContainerProtocol {
    func decode<T: Decodable>(forKey key: Key) throws -> T {
        return try decode(T.self, forKey: key)
    }
    
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
