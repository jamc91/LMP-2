//
//  StandingsMLBModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 18/08/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct StandingResultsMLB: Codable {
    var records: [Records]
    
    init() {
            records = [Records]()
    }
}

struct Records: Codable, Identifiable {
    var id = UUID()
    var division: Division?
    var teamRecords: [TeamRecords]
    
    enum CodingKeys: String, CodingKey {
        case division, teamRecords
    }
}

struct Division: Codable {
    var name: String
    var nameShort: String
}

struct TeamRecords: Codable, Identifiable {
    var id = UUID()
    var team: TeamMLB
    var streak: Streak?
    var gamesBack: String
    var records: RecordsResult
    var wins: Int
    var losses: Int
    var runDifferential: Int
    var winningPercentage: String
    
    enum CodingKeys: String, CodingKey {
        case team, streak, gamesBack, records,wins, losses, runDifferential, winningPercentage
    }
}

struct TeamMLB: Codable {
    var id: Int
    var name: String
    var abbreviation: String
}

struct Streak: Codable {
    var streakCode: String
}

struct RecordsResult: Codable {
    var splitRecords: [SplitRecords]
    
}

struct SplitRecords: Codable, Identifiable {
    var id = UUID()
    var wins: Int
    var losses: Int
    var type: String
    var pct: String
    
    enum CodingKeys: String, CodingKey {
        case wins, losses, type, pct
    }
}
