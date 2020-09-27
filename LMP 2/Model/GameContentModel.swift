//
//  GameContentModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 16/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct ContentResults: Codable {
    var gameData: GameData?
    var liveData: LiveData?
    
}

struct GameData: Codable {
    var teams: CGTeams
}

struct CGTeams: Codable {
    var home, away: CGTeamsContent
}

struct CGTeamsContent: Codable {
    var abbreviation: String
}

struct LiveData: Codable {
    var plays: CPlays?
    var linescore: CLinescore?
    var boxscore: CBoxscore?
    var decisions: CDecisions?
    var leaders: CLeaders?
}

struct CPlays: Codable {
    
}

struct CLinescore: Codable {
    var currentInning: Int
    var currentInningOrdinal: String
    var inningState: String
    var inningHalf: String
    var isTopInning: Bool
    var scheduledInnings: Int
    var teams: CLTeams
    var balls: Int?
    var strikes: Int?
    var outs: Int?
    
}

struct CLTeams: Codable {
    var home, away: CTeamsContent
}

struct CTeamsContent: Codable {
    var runs, hits, errors, leftOnBase: Int?
}

struct CBoxscore: Codable {
        
}

struct CDecisions: Codable {
    
}

struct CLeaders: Codable {
    
}
