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
        formatter.dateFormat = "MM/d/YYYY"
        return formatter.string(from: self)
    }
}

extension URL {
    static func games(date: String, league: League) -> URL {
        URL(string: "https://statsapi.mlb.com/api/v1/schedule?language=es&leagueId=\(league.rawValue.0)&sportId=\(league.rawValue.1)&date=\(date)&sortBy=gameDate&hydrate=team,linescore(matchup,runners),person,stats,probablePitcher,decisions")!
    }
    static var standing: URL {
        URL(string: "https://api.lmp.mx/3.0.0/standing")!
    }
    
    static func leaders(mode: String, season: String, category: String, order: String) -> URL {
        URL(string: "https://api.lmp.mx/3.0.0/leaders?mode=\(mode)&type=\(season)&column=\(category)&order=\(order)")!
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
    func hourFormat() -> String {
        
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


