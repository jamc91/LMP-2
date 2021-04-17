//
//  Boxscore.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/11/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import SwiftUI

struct Boxscore: Codable {
    let teams: BoxscoreTeams
    let info: [FieldList]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        teams = try container.decode(forKey: .teams, default: BoxscoreTeams())
        info = try container.decode(forKey: .info, default: [FieldList]())
    }
    
    init(teams: BoxscoreTeams = BoxscoreTeams(), info: [FieldList] = []) {
        self.teams = teams
        self.info = info
    }
}

struct BoxscoreTeams: Codable {
    let away, home: BoxscoreTeamsContent
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        away = try container.decode(forKey: .away, default: BoxscoreTeamsContent())
        home = try container.decode(forKey: .home, default: BoxscoreTeamsContent())
    }
    
    init(away: BoxscoreTeamsContent = BoxscoreTeamsContent(), home: BoxscoreTeamsContent = BoxscoreTeamsContent()) {
        self.away = away
        self.home = home
    }
}

struct BoxscoreTeamsContent: Codable {
    let teamStats: TeamStats
    let players: [String: Player]
    let batters, pitchers, bench, bullpen, battingOrder: [Int]
    let info: [Info]
    let note: [FieldList]
    
    var battersBoxscore: [Int] {
        batters.filter {
            guard let player = players["ID\($0)"] else { return false }
            return (battingOrder.contains($0) || player.gameStatus.isSubstitute || player.stats.batting.atBats > 0)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        teamStats = try container.decode(forKey: .teamStats, default: TeamStats())
        players = try container.decode(forKey: .players, default: [String: Player]())
        batters = try container.decode(forKey: .batters, default: [Int]())
        pitchers = try container.decode(forKey: .pitchers, default: [Int]())
        bench = try container.decode(forKey: .bench, default: [Int]())
        bullpen = try container.decode(forKey: .bullpen, default: [Int]())
        battingOrder = try container.decode(forKey: .battingOrder, default: [Int]())
        info = try container.decode(forKey: .info, default: [Info]())
        note = try container.decode(forKey: .note, default: [FieldList]())
    }
    
    init(teamStats: TeamStats = TeamStats(), players: [String: Player] = [:], batters: [Int] = [], pitchers: [Int] = [], bench: [Int] = [], bullpen: [Int] = [], battingOrder: [Int] = [], info: [Info] = [], note: [FieldList] = []) {
        
        self.teamStats = teamStats
        self.players = players
        self.batters = batters
        self.pitchers = pitchers
        self.bench = bench
        self.bullpen = bullpen
        self.battingOrder = battingOrder
        self.info = info
        self.note = note
    }
}

struct Info: Identifiable, Codable {
    var id = UUID()
    let title: String
    let fieldList: [FieldList]
    
    enum CodingKeys: String, CodingKey {
        case title, fieldList
    }
}
