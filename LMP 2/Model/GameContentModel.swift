//
//  GameContentModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 16/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct ContentResults: Codable {
    
    var gameData: GameData
    var liveData: LiveData
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        gameData = try container.decode(forKey: .gameData, default: GameData())
        liveData = try container.decode(forKey: .liveData, default: LiveData())
    }
    
    init() {
        gameData = GameData()
        liveData = LiveData()
    }
    
    static let `default` = ContentResults()
    
}

struct GameData: Codable {
    var teams: CGTeams
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        teams = try container.decode(forKey: .teams, default: CGTeams())
    }
    
    init() {
        teams = CGTeams()
    }
}

struct CGTeams: Codable {
    var home, away: CGTeamsContent
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        home = try container.decode(forKey: .home, default: CGTeamsContent())
        away = try container.decode(forKey: .away, default: CGTeamsContent())
    }
    
    init() {
        home = CGTeamsContent()
        away = CGTeamsContent()
    }
}

struct CGTeamsContent: Codable {
    var abbreviation, teamName: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        abbreviation = try container.decode(forKey: .abbreviation, default: "")
        teamName = try container.decode(forKey: .teamName, default: "")
    }
    
    init() {
        abbreviation = ""
        teamName = ""
    }
}

struct LiveData: Codable {
    var plays: CPlays
    var linescore: Linescore
    var boxscore: CBoxscore
    var decisions: CDecisions
    var leaders: CLeaders
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        plays = try container.decode(forKey: .plays, default: CPlays())
        linescore = try container.decode(forKey: .linescore, default: Linescore())
        boxscore = try container.decode(forKey: .boxscore, default: CBoxscore())
        decisions = try container.decode(forKey: .decisions, default: CDecisions())
        leaders = try container.decode(forKey: .leaders, default: CLeaders())
    }
    
    init() {
        plays = CPlays()
        linescore = Linescore()
        boxscore = CBoxscore()
        decisions = CDecisions()
        leaders = CLeaders()
    }
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
    var innings: [Innings]
    var teams: CLTeams
    var offense: CLOffense
    var balls: Int
    var strikes: Int
    var outs: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        currentInning = try container.decode(forKey: .currentInning, default: 9)
        currentInningOrdinal = try container.decode(forKey: .currentInningOrdinal, default: "")
        inningState = try container.decode(forKey: .inningState, default: "")
        inningHalf = try container.decode(forKey: .inningHalf, default: "")
        isTopInning = try container.decode(forKey: .isTopInning, default: false)
        scheduledInnings = try container.decode(forKey: .scheduledInnings, default: 0)
        innings = try container.decode(forKey: .innings, default: [Innings]())
        teams = try container.decode(forKey: .teams, default: CLTeams())
        offense = try container.decode(forKey: .offense, default: CLOffense())
        balls = try container.decode(forKey: .balls, default: 0)
        strikes = try container.decode(forKey: .strikes, default: 0)
        outs = try container.decode(forKey: .outs, default: 0)
    }
    
    init() {
        currentInning = 9
        currentInningOrdinal = ""
        inningState = ""
        inningHalf = ""
        isTopInning = false
        scheduledInnings = 0
        innings = [Innings]()
        teams = CLTeams()
        offense = CLOffense()
        balls = 0
        strikes = 0
        outs = 0
    }
    
    var getNumberInnings: Int {
        if currentInning > scheduledInnings {
            return currentInning
        } else {
            return 9
        }
    }
    
    
}

struct CLTeams: Codable {
    var home, away: CTeamsContent
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        home = try container.decode(forKey: .home, default: CTeamsContent())
        away = try container.decode(forKey: .away, default: CTeamsContent())
    }
    
    init() {
        home = CTeamsContent()
        away = CTeamsContent()
    }
}

struct CTeamsContent: Codable {
    var runs, hits, errors, leftOnBase: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        runs = try container.decode(forKey: .runs, default: 0)
        hits = try container.decode(forKey: .hits, default: 0)
        errors = try container.decode(forKey: .errors, default: 0)
        leftOnBase = try container.decode(forKey: .leftOnBase, default: 0)
    }
    
    init() {
        runs = 0
        hits = 0
        errors = 0
        leftOnBase = 0
    }
}

struct CLOffense: Codable {
    var first, second, third: CLInfoBase?
    
    var diamondState: [String] {
        var diamondValue = [String]()
        if first != nil {
            diamondValue.append("squareshape.fill")
        } else {
            diamondValue.append("squareshape")
        }
        if second != nil {
            diamondValue.append("squareshape.fill")
        } else {
            diamondValue.append("squareshape")
        }
        if third != nil {
            diamondValue.append("squareshape.fill")
        } else {
            diamondValue.append("squareshape")
        }
        return diamondValue
    }
}

struct CBoxscore: Codable {
        
}

struct CDecisions: Codable {
    
}

struct CLeaders: Codable {
    
}

struct CLInfoBase: Codable {
    var id: Int
    var fullName: String
    var link: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        fullName = try container.decode(forKey: .fullName, default: "")
        link = try container.decode(forKey: .link, default: "")
    }
    
    init() {
        self.id = 0
        self.fullName = ""
        self.link = ""
    }
}
