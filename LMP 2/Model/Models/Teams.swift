//
//  Teams.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Teams: Codable {
    let away: TeamContent
    let home: TeamContent
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        away = try container.decode(forKey: .away, default: TeamContent())
        home = try container.decode(forKey: .home, default: TeamContent())
    }
    
    init(away: TeamContent = TeamContent(), home: TeamContent = TeamContent()) {
        self.away = away
        self.home = home
    }
}

struct TeamsLinescore: Codable {
    let away: TeamInformation
    let home: TeamInformation
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        away = try container.decode(forKey: .away, default: TeamInformation())
        home = try container.decode(forKey: .home, default: TeamInformation())
    }
    
    init(away: TeamInformation = TeamInformation(), home: TeamInformation = TeamInformation()) {
        self.away = away
        self.home = home
    }
}

struct TeamContent: Codable {
    let leagueRecord: LeagueRecord
    let score: Int
    let team: TeamInformation
    let probablePitcher: ProbablePitcher
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        leagueRecord = try container.decode(forKey: .leagueRecord, default: LeagueRecord())
        score = try container.decode(forKey: .score, default: 0)
        team = try container.decode(forKey: .team, default: TeamInformation())
        probablePitcher = try container.decode(forKey: .probablePitcher, default: ProbablePitcher())
        
    }
    
    init(leagueRecord: LeagueRecord = LeagueRecord(), score: Int = 0, team: TeamInformation = TeamInformation(), probablePitcher: ProbablePitcher = ProbablePitcher()) {
        self.leagueRecord = leagueRecord
        self.score = score
        self.team = team
        self.probablePitcher = probablePitcher
    }
}

struct LeagueRecord: Codable {
    let wins: Int
    let losses: Int
    let pct: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        wins = try container.decode(forKey: .wins, default: 0)
        losses = try container.decode(forKey: .losses, default: 0)
        pct = try container.decode(forKey: .pct, default: "")
    }
    
    init(wins: Int = 0, losses: Int = 0, pct: String = "") {
        self.wins = wins
        self.losses = losses
        self.pct = pct
    }
}

struct TeamInformation: Codable {
    let id: Int
    let venue: Venue
    let abbreviation: String
    let teamName: String
    let league: LeagueInformation
    let sport: LeagueInformation
    let shortName: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        venue = try container.decode(forKey: .venue, default: Venue())
        abbreviation = try container.decode(forKey: .abbreviation, default: "")
        teamName = try container.decode(forKey: .teamName, default: "")
        league = try container.decode(forKey: .league, default: LeagueInformation())
        sport = try container.decode(forKey: .sport, default: LeagueInformation())
        shortName = try container.decode(forKey: .shortName, default: "")
    }
    
    init(id: Int = 0, venue: Venue = Venue(), abbreviation: String = "", teamName: String = "", league: LeagueInformation = LeagueInformation(), sport: LeagueInformation = LeagueInformation(), shortName: String = "") {
        self.id = id
        self.venue = venue
        self.abbreviation = abbreviation
        self.teamName = teamName
        self.league = league
        self.sport = sport
        self.shortName = shortName
        
    }
}

struct LeagueInformation: Codable {
    let id: Int
    let name: String
    
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

struct Venue: Codable {
    let id: Int
    let name: String
    
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

