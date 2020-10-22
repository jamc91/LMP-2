//
//  ScoreboardModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 02/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct ScoreboardResults: Codable {
    var totalGamesInProgress: Int
    var dates: [Dates]
    
    static var `default` = ScoreboardResults(totalGamesInProgress: 0, dates: [Dates]())
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
    var linescore: Linescore
    
    enum CodingKeys: String, CodingKey {
        case gamePk, gameDate, teams, status, linescore
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        gamePk = try container.decode(forKey: .gamePk, default: 0)
        gameDate = try container.decode(forKey: .gameDate, default: "")
        status = try container.decode(forKey: .status, default: Status())
        teams = try container.decode(forKey: .teams, default: Teams())
        linescore = try container.decode(forKey: .linescore, default: Linescore())
    }
}

struct Status: Codable {
    
    var abstractGameState: String
    var codedGameState: String
    var detailedState: String
    var statusCode: String
    var startTimeTBD: Bool
    var abstractGameCode: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        abstractGameState = try container.decode(forKey: .abstractGameState, default: "")
        codedGameState = try container.decode(forKey: .codedGameState, default: "")
        detailedState = try container.decode(forKey: .detailedState, default: "")
        statusCode = try container.decode(forKey: .statusCode, default: "")
        startTimeTBD = try container.decode(forKey: .startTimeTBD, default: false)
        abstractGameCode = try container.decode(forKey: .abstractGameCode, default: "")
    }
    
    init() {
        
        abstractGameState = ""
        codedGameState = ""
        detailedState = ""
        statusCode = ""
        startTimeTBD = false
        abstractGameCode = ""
    }
}

struct Teams: Codable {
    var away, home: TeamData
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        away = try container.decode(forKey: .away, default: TeamData())
        home = try container.decode(forKey: .home, default: TeamData())
    }
    
    init() {
        
        away = TeamData()
        home = TeamData()
    }
}

struct TeamData: Codable {
    var leagueRecord: LeagueRecord
    var score: Int
    var probablePitcher: ProbablePitcher
    var team: Team
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        leagueRecord = try container.decode(forKey: .leagueRecord, default: LeagueRecord())
        score = try container.decode(forKey: .score, default: 0)
        probablePitcher = try container.decode(forKey: .probablePitcher, default: ProbablePitcher())
        team = try container.decode(forKey: .team, default: Team())
    }
    
    init() {
        
        leagueRecord = LeagueRecord()
        score = 0
        probablePitcher = ProbablePitcher()
        team = Team()
    }
}

struct LeagueRecord: Codable {
    var wins, losses: Int
    var pct: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        wins = try container.decode(forKey: .wins, default: 0)
        losses = try container.decode(forKey: .losses, default: 0)
        pct = try container.decode(forKey: .pct, default: "")
    }
    
    init() {
        wins = 0
        losses = 0
        pct = ""
    }
}

struct Team: Codable {
    var id: Int
    var name: String
    var abbreviation: String
    var teamName: String
    var sport: SportID
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        name = try container.decode(forKey: .name, default: "")
        abbreviation = try container.decode(forKey: .abbreviation, default: "")
        teamName = try container.decode(forKey: .teamName, default: "")
        sport = try container.decode(forKey: .sport, default: SportID())
    }
    
    init() {
        id = 0
        name = ""
        abbreviation = ""
        teamName = ""
        sport = SportID()
    }
}

struct SportID: Codable {
    var id: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
    }
    
    init() {
        self.id = 0
    }
}

struct ProbablePitcher: Codable {
    var id: Int
    var link: String
    var primaryNumber: String
    var boxscoreName: String
    var stats: [Stats]
    var pitchHand: PitchHand
    
    enum CodingKeys: String, CodingKey {
        case id, link, primaryNumber, boxscoreName, stats, pitchHand
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        link = try container.decode(forKey: .link, default: "")
        primaryNumber = try container.decode(forKey: .primaryNumber, default: "--")
        boxscoreName = try container.decode(forKey: .boxscoreName, default: "unknown")
        stats = try container.decode(forKey: .stats, default: [Stats()])
        pitchHand = try container.decode(forKey: .pitchHand, default: PitchHand())
    }
    
    init() {
        id = 0
        link = ""
        primaryNumber = "--"
        boxscoreName = "unknown"
        stats = [Stats()]
        pitchHand = PitchHand()
        
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(forKey: .type, default: Type())
        group = try container.decode(forKey: .group, default: GroupStat())
        stats = try container.decode(forKey: .stats, default: StatsContent())
    }
    
    init() {
        type = Type()
        group = GroupStat()
        stats = StatsContent()
    }
}

struct StatsContent: Codable {
    var era: String
    var wins, losses: Int
    
    enum CodingKeys: String, CodingKey {
        case era, wins, losses
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        era = try container.decode(forKey: .era, default: "-.-- ERA")
        wins = try container.decode(forKey: .wins, default: 0)
        losses = try container.decode(forKey: .losses, default: 0)
    }
    
    init() {
        era = "--"
        wins = 0
        losses = 0
    }
}

struct PitchHand: Codable {
    var code, description: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try container.decode(forKey: .code, default: "")
        description = try container.decode(forKey: .description, default: "")
    }
    
    init() {
        self.code = "?"
        self.description = "????"
    }
}

struct Type: Codable {
    var displayName: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        displayName = try container.decode(forKey: .displayName, default: "statsSingleSeason")
    }
    
    init() {
        displayName = "statsSingleSeason"
    }
}

struct GroupStat: Codable {
    var displayName: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        displayName = try container.decode(forKey: .displayName, default: "pitching")
    }
    
    init() {
        displayName = "pitching"
    }
}
//MARK: - Linescore
struct Linescore: Codable {
    var currentInning: Int
    var currentInningOrdinal: String
    var inningState: String
    var inningHalf: String
    var isTopInning: Bool
    var scheduledInnings: Int
    var innings: [Innings]
    var teams: TeamsLinescore
    var offense: Offense
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
        teams = try container.decode(forKey: .teams, default: TeamsLinescore())
        offense = try container.decode(forKey: .offense, default: Offense())
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
        teams = TeamsLinescore()
        offense = Offense()
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

//MARK: - Inning
struct Innings: Codable, Identifiable {
    var id = UUID()
    var num: Int
    var ordinalNum: String
    var home, away: InningResults
    
    enum CodingKeys: String, CodingKey {
        case num, ordinalNum, home, away
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        num = try container.decode(forKey: .num, default: 0)
        ordinalNum = try container.decode(forKey: .ordinalNum, default: "")
        home = try container.decode(forKey: .home, default: InningResults())
        away = try container.decode(forKey: .away, default: InningResults())
    }
    
    init() {
        num = 0
        ordinalNum = ""
        home = InningResults()
        away = InningResults()
    }
}

struct InningResults: Codable {
    var runs, hits, errors , leftOnBase: Int
    
    enum CodingKeys: String, CodingKey {
        case runs, hits, errors, leftOnBase
    }
    
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

//MARK: - Teams Linescore
struct TeamsLinescore: Codable {
    var home, away: TeamsResults
    
    enum CodingKeys: String, CodingKey {
        case home, away
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        home = try container.decode(forKey: .home, default: TeamsResults())
        away = try container.decode(forKey: .away, default: TeamsResults())
    }
    
    init() {
        home = TeamsResults()
        away = TeamsResults()
    }
}

struct TeamsResults: Codable {
    var runs, hits, errors, leftOnBase: Int
    
    enum CodingKeys: String, CodingKey {
        case runs, hits, errors, leftOnBase
    }
    
    init() {
        runs = 0
        hits = 0
        errors = 0
        leftOnBase = 0
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        runs = try container.decode(forKey: .runs, default: 0)
        hits = try container.decode(forKey: .hits, default: 0)
        errors = try container.decode(forKey: .errors, default: 0)
        leftOnBase = try container.decode(forKey: .leftOnBase, default: 0)
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


