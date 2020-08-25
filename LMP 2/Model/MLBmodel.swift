//
//  MLBmodel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/07/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct resultsMLB: Codable {
    var totalGamesInProgress: Int
    var dates: [Dates]
    
}

struct Dates: Codable, Identifiable {
    
    var id = UUID()
    var games: [Games]

    enum CodingKeys: String, CodingKey {
        case games
    }
}

struct Games: Codable, Identifiable {
    var id = UUID()
    var gamePk: Int
    var gameDate: String
    var status: Status
    var teams: Teams
    var linescore: Linescore?
    
    enum CodingKeys: String, CodingKey {
        case gamePk, gameDate, teams, status, linescore
    }
}
//MARK: - Status
struct Status: Codable {
    var abstractGameState: String
    var codedGameState: String
    var detailedState: String
    var statusCode: String
    var abstractGameCode: String
    
    enum CodingKeys: String, CodingKey {
        case abstractGameState, codedGameState, detailedState, statusCode, abstractGameCode
    }
    
    var valueOrder: Int {
        switch abstractGameState {
        case "Final":
            return 2
        case "Preview":
            return 1
        default:
            return 0
        }
    }
}

//MARK: - Teams
struct Teams: Codable {
    var away, home: TeamData
}

struct TeamData: Codable {
    var leagueRecord: LeagueRecord
    var score: Int?
    var probablePitcher: ProbablePitcher?
    var team: Team
    
    enum CodingKeys: String, CodingKey {
        case leagueRecord, score, probablePitcher, team
    }
    
    func getProbablePicher() -> ProbablePitcher {
        if let probablePitcher = self.probablePitcher {
            return probablePitcher
        } else {
            let probablePitcherPlaceholder = ProbablePitcher(id: 1, primaryNumber: "", boxscoreName: "unknown", stats: [Stats(type: Type(displayName: "statsSingleSeason"), group: GroupStat(displayName: "pitching"), stats: StatsContent(era: "--", wins: 0, losses: 0))], pitchHand: PitchHand(code: "-", description: "none"))
            return probablePitcherPlaceholder
        }
    }
    
}

struct LeagueRecord: Codable {
    var wins, losses: Int
    var pct: String
}

struct Team: Codable {
    var id: Int
    var name: String
    var abbreviation: String
    var teamName: String
}

struct ProbablePitcher: Codable {
    var id: Int
    var primaryNumber: String?
    var boxscoreName: String
    var stats: [Stats]?
    var pitchHand: PitchHand
    
    enum CodingKeys: String, CodingKey {
        case id, primaryNumber, boxscoreName, stats, pitchHand
    }
    
    func getStats() -> [Stats]? {
        var getStatsArray = [Stats]()
        guard let statsArray = self.stats else {
            return nil
        }
        for stat in statsArray {
            if stat.group.displayName.contains("pitching") && stat.type.displayName.contains("statsSingleSeason") {
                getStatsArray.append(stat)
            }
        }
        return getStatsArray
    }
    
    var imageURL: URL {
        let url = URL(string: "https://content.mlb.com/images/headshots/current/60x60/\(id)@2x.png")!
        return url
    }
}

struct Stats: Codable, Identifiable {
    var id = UUID()
    var type: Type
    var group: GroupStat
    var stats: StatsContent
    
    enum CodingKeys: String, CodingKey {
        case type, group, stats
    }
}

struct StatsContent: Codable {
    var era: String?
    var wins, losses: Int?
}

struct PitchHand: Codable {
    var code, description: String
}

struct Type: Codable {
    var displayName: String
}

struct GroupStat: Codable {
    var displayName: String
}
//MARK: - Linescore
struct Linescore: Codable {
    var currentInning: Int?
    var currentInningOrdinal: String?
    var inningState: String?
    var inningHalf: String?
    var innings: [Innings]
    var teams: TeamsLinescore
    var offense: Offense
    var balls: Int?
    var strikes: Int?
    var outs: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentInning, currentInningOrdinal, inningState, inningHalf, innings, teams, offense, balls, strikes, outs
    }
    
    var getScore: [Innings] {
        var scoreInning = [Innings]()
        
            for item in innings {
                if scoreInning.count < 9 {
                    scoreInning.append(item)
            }
        }
        return scoreInning
    }
    
    var inningArrowStatus: String {
        switch inningState {
        case "Top":
            return "arrowtriangle.up.fill"
        default:
            return "arrowtriangle.down.fill"
        }
    }
    
    var ballsState: [String] {
        if let ballsValue = balls {
            switch ballsValue {
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
        } else {
            return ["circle", "circle", "circle", "circle"]
        }
    }
    
    var strikesState: [String] {
        if let strikesValue = strikes {
            switch strikesValue {
            case 1:
                return ["circle.fill", "circle", "circle"]
            case 2:
                return ["circle.fill", "circle.fill", "circle"]
            case 3:
                return ["circle.fill", "circle.fill", "circle.fill"]
            default:
                return ["circle", "circle", "circle"]
            }
        } else {
            return ["circle", "circle", "circle"]
        }
    }
    
    var outsState: [String] {
        if let outsValue = outs {
            switch outsValue {
            case 1:
                return ["circle.fill", "circle", "circle"]
            case 2:
                return ["circle.fill", "circle.fill", "circle"]
            case 3:
                return ["circle.fill", "circle.fill", "circle.fill"]
            default:
                return ["circle", "circle", "circle"]
            }
        } else {
            return ["circle", "circle", "circle"]
        }
    }
}

//MARK: - Inning
struct Innings: Codable, Identifiable {
    var id = UUID()
    var num: Int?
    var ordinalNum: String?
    var home, away: InningResults?
    
    enum CodingKeys: String, CodingKey {
        case num, ordinalNum, home, away
    }
}

struct InningResults: Codable {
    var runs: Int?
    var hits, errors , leftOnBase: Int?
    
    enum CodingKeys: String, CodingKey {
        case runs, hits, errors, leftOnBase
    }
    
    var getRuns: String {
        if runs != nil {
            return "\(runs ?? 0)"
            } else {
            return ""
        }
    }
}

//MARK: - Teams Linescore
struct TeamsLinescore: Codable {
    var home, away: TeamsResults
}

struct TeamsResults: Codable {
    var runs, hits, errors, leftOnBase: Int?
}

struct Offense: Codable {
    var first: InfoBase?
    var second: InfoBase?
    var third: InfoBase?
    
    enum CodingKeys: String, CodingKey {
        case first, second, third
    }
    
    var diamondState: [String] {
        var diamondValue = [String]()
        if first != nil {
            diamondValue.append("square.fill")
        } else {
            diamondValue.append("square")
        }
        if second != nil {
            diamondValue.append("square.fill")
        } else {
            diamondValue.append("square")
        }
        if third != nil {
            diamondValue.append("square.fill")
        } else {
            diamondValue.append("square")
        }
        return diamondValue
    }
}

struct InfoBase: Codable {
    var id: Int?
    var fullName: String?
    var link: String?
}

