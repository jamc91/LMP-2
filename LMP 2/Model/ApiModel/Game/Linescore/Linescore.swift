//
//  LinescoreTest.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

enum SelectionTeam: String, CaseIterable, Identifiable {
    case home, away
    
    var id: String { rawValue }
    
}

struct Linescore: Codable {
    
    let currentInning: Int
    let currentInningOrdinal: String
    let isTopInning: Bool
    let scheduledInnings: Int
    let innings: [Inning]
    let teams: TeamsLinescoreResults
    let offense: Offense
    let balls: Int
    let strikes: Int
    let outs: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        currentInning = try container.decode(forKey: .currentInning, default: 9)
        currentInningOrdinal = try container.decode(forKey: .currentInningOrdinal, default: "")
        isTopInning = try container.decode(forKey: .isTopInning, default: false)
        scheduledInnings = try container.decode(forKey: .scheduledInnings, default: 0)
        innings = try container.decode(forKey: .innings, default: [Inning]())
        teams = try container.decode(forKey: .teams, default: TeamsLinescoreResults())
        offense = try container.decode(forKey: .offense, default: Offense())
        balls = try container.decode(forKey: .balls, default: 0)
        strikes = try container.decode(forKey: .strikes, default: 0)
        outs = try container.decode(forKey: .outs, default: 0)
    }
    
    init(currentInning: Int = 1, currentInningOrdinal: String = "", isTopInning: Bool = false, scheduledInnings: Int = 9, innings: [Inning] = [], teams: TeamsLinescoreResults = TeamsLinescoreResults(), offense: Offense = Offense(), balls: Int = 0, strikes: Int = 0, outs: Int = 0) {
        self.currentInning = currentInning
        self.currentInningOrdinal = currentInningOrdinal
        self.isTopInning = isTopInning
        self.scheduledInnings = scheduledInnings
        self.innings = innings
        self.teams = teams
        self.offense = offense
        self.balls = balls
        self.strikes = strikes
        self.outs = outs
    }
    
    var getNumberInnings: Int {
        if currentInning > scheduledInnings {
            return currentInning
        } else {
            return 9
        }
    }
    
    var inningArrowStatus: String {
        isTopInning ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
    }
    
    var ballsState: [String] {
        switch balls {
        case 1:
            return ["circle.fill", "circle", "circle", "circle"]
        case 2:
            return ["circle.fill", "circle.fill", "circle", "circle"]
        case 3:
            return ["circle.fill", "circle.fill", "circle.fill", "circle"]
        case 4:
            return ["circle.fill", "circle.fill", "circle.fill", "circle.fill"]
        default:
            return ["circle", "circle", "circle", "circle"]
        }
    }
    
    var strikesState: [String] {
            switch strikes {
            case 1:
                return ["circle.fill", "circle", "circle"]
            case 2:
                return ["circle.fill", "circle.fill", "circle"]
            case 3:
                return ["circle.fill", "circle.fill", "circle.fill"]
            default:
                return ["circle", "circle", "circle"]
        }
    }
    
    var outsState: [String] {
        switch outs {
        case 1:
            return ["circle.fill", "circle", "circle"]
        case 2:
            return ["circle.fill", "circle.fill", "circle"]
        case 3:
            return ["circle.fill", "circle.fill", "circle.fill"]
        default:
            return ["circle", "circle", "circle"]
        }
    }
}


struct TeamsLinescoreResults: Codable {
    let away, home: InningTeamResults
    
    init(away: InningTeamResults = InningTeamResults(), home: InningTeamResults = InningTeamResults()) {
        self.away = away
        self.home = home
    }
}

struct Offense: Codable {
    var first: InfoBase?
    var second: InfoBase?
    var third: InfoBase?
    
    var diamondState: [(String, String)] {
        var diamondValue = [(String, String)]()
        if first != nil {
            diamondValue.append(("squareshape.fill", "ActiveColor"))
        } else {
            diamondValue.append(("squareshape", "LightGray"))
        }
        if second != nil {
            diamondValue.append(("squareshape.fill", "ActiveColor"))
        } else {
            diamondValue.append(("squareshape", "LightGray"))
        }
        if third != nil {
            diamondValue.append(("squareshape.fill", "ActiveColor"))
        } else {
            diamondValue.append(("squareshape", "LightGray"))
        }
        return diamondValue
    }
}

struct InfoBase: Codable {
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
