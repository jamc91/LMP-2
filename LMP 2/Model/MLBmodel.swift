//
//  MLBmodel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/07/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct resultsMLB: Codable {
    var dates: [Dates]
}

struct Dates: Codable, Identifiable, Equatable {
    
    var id = UUID()
    var games: [Games]
    
    enum CodingKeys: String, CodingKey {
        case games
    }
    
    static func == (lhs: Dates, rhs: Dates) -> Bool {
        return lhs.id == lhs.id
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
    
    var time: String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = .current
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if let hour = formatter.date(from: gameDate) {
        formatter.dateFormat = "h:mm a"
        let dateString = formatter.string(from: hour)
        return dateString
            
        }
        return ""
    }
}
//MARK: - Status
struct Status: Codable {
    var abstractGameState: String
    var codedGameState: String
    var detailedState: String
    var statusCode: String
    var abstractGameCode: String
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
    
    enum CodingKeys: String, CodingKey {
        case id
    }
    
    var imageURL: URL {
        let url = URL(string: "https://content.mlb.com/images/headshots/current/60x60/\(id)@2x.png")!
        return url
    }
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
        case "top":
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
