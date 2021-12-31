//
//  Teams.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import SwiftUI

struct Teams<T: Codable>: Codable {
    let away, home: T
    
}

struct TeamInformation: Codable {
    let id: Int
    let name: String
    let venue: Venue
    let abbreviation: String
    let teamName: String
    let league: LeagueInformation
    let sport: LeagueInformation
    let shortName: String
    let record: RecordTeam
    
    var teamBackgroundColor: Color {
        switch id {
        case 680:
            return Color("blue")
        case 5482:
            return Color("brown")
        case 5483:
            return Color("darkBlue")
        case 677:
            return Color("Orange")
        case 678:
            return Color("cayenne")
        case 676:
            return Color("red")
        case 673:
            return Color("red")
        case 674:
            return Color("blue")
        default:
            return Color.white
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        name = try container.decode(forKey: .name, default: "")
        venue = try container.decode(forKey: .venue, default: Venue())
        abbreviation = try container.decode(forKey: .abbreviation, default: "")
        teamName = try container.decode(forKey: .teamName, default: "")
        league = try container.decode(forKey: .league, default: LeagueInformation())
        sport = try container.decode(forKey: .sport, default: LeagueInformation())
        shortName = try container.decode(forKey: .shortName, default: "")
        record = try container.decode(forKey: .record, default: RecordTeam())
    }
    
    init(id: Int = 0, name: String = "", venue: Venue = Venue(), abbreviation: String = "", teamName: String = "", league: LeagueInformation = LeagueInformation(), sport: LeagueInformation = LeagueInformation(), shortName: String = "", record: RecordTeam = RecordTeam()) {
        self.id = id
        self.name = name
        self.venue = venue
        self.abbreviation = abbreviation
        self.teamName = teamName
        self.league = league
        self.sport = sport
        self.shortName = shortName
        self.record = record
    }
}

struct LeagueInformation: Codable {
    let id: Int
    let name: String
    
    var nameLeague: String {
        switch id {
        case 103, 104:
            return "Major League Baseball"
        case 132:
            return "Mexican Pacific League"
        case 162:
            return "Caribbean Series"
        default:
            return "Liga Desconocida"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        name = try container.decode(forKey: .name, default: "")
    }
    
    init(id: Int = 0, name: String = "") {
        self.id = id
        self.name = name
    }
}





