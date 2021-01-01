//
//  PlayerStats.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/11/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct ProbablePitcher: Codable {
    var id: Int
    var primaryNumber: String
    var boxscoreName: String
    var stats: [Stats]
    var pitchHand: InfoPosition
    
    enum CodingKeys: String, CodingKey {
        case id, primaryNumber, boxscoreName, stats, pitchHand
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        primaryNumber = try container.decode(forKey: .primaryNumber, default: "--")
        boxscoreName = try container.decode(forKey: .boxscoreName, default: "unknown")
        stats = try container.decode(forKey: .stats, default: [Stats()])
        pitchHand = try container.decode(forKey: .pitchHand, default: InfoPosition())
    }
    
    init() {
        id = 0
        primaryNumber = "--"
        boxscoreName = "unknown"
        stats = [Stats()]
        pitchHand = InfoPosition()
        
    }
}

struct Stats: Codable, Identifiable {
    var id = UUID()
    var type: TypeContent
    var group: GroupContent
    var stats: StatsContent
    
    enum CodingKeys: String, CodingKey {
        case type, group, stats
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(forKey: .type, default: TypeContent())
        group = try container.decode(forKey: .group, default: GroupContent())
        stats = try container.decode(forKey: .stats, default: StatsContent())
    }
    
    init() {
        type = TypeContent()
        group = GroupContent()
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

struct InfoPosition: Codable {
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

struct TypeContent: Codable {
    var displayName: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        displayName = try container.decode(forKey: .displayName, default: "statsSingleSeason")
    }
    
    init() {
        displayName = "statsSingleSeason"
    }
}

struct GroupContent: Codable {
    var displayName: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        displayName = try container.decode(forKey: .displayName, default: "pitching")
    }
    
    init() {
        displayName = "pitching"
    }
}

struct Players: Codable {
    let boxscoreName: String
    let fullName: String
    let position: Position
    let stats: Stats
    let seasonStats: SeasonStats
    let gameStatus: GameStatus
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        boxscoreName = try container.decode(forKey: .boxscoreName, default: "")
        fullName = try container.decode(forKey: .fullName, default: "")
        position = try container.decode(forKey: .position, default: Position())
        stats = try container.decode(forKey: .stats, default: Stats())
        seasonStats = try container.decode(forKey: .seasonStats, default: SeasonStats())
        gameStatus = try container.decode(forKey: .gameStatus, default: GameStatus())
    }
    
    init(boxscoreName: String = "", fullName: String = "", position: Position = Position(), stats: Stats = Stats(), seasonStats: SeasonStats = SeasonStats(), gameStatus: GameStatus = GameStatus()) {
        self.boxscoreName = boxscoreName
        self.fullName = fullName
        self.position = position
        self.stats = stats
        self.seasonStats = seasonStats
        self.gameStatus = gameStatus
    }
    
    struct Position: Codable {
        let abbreviation: String
        let type: String
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            abbreviation = try container.decode(forKey: .abbreviation, default: "")
            type = try container.decode(forKey: .type, default: "")
        }
        
        init(abbreviation: String = "", type: String = "") {
            self.abbreviation = abbreviation
            self.type = type
        }
    }
    
    struct Stats: Codable {
        let batting: BattingStats
        let pitching: PitchingStats
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            batting = try container.decode(forKey: .batting, default: BattingStats())
            pitching = try container.decode(forKey: .pitching, default: PitchingStats())
        }
        
        init(batting: BattingStats = BattingStats(), pitching: PitchingStats = PitchingStats()) {
            self.batting = batting
            self.pitching = pitching
        }
        
    }
    
    struct SeasonStats: Codable {
        let batting: SeasonStatsContent
        let pitching: SeasonStatsContent
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            batting = try container.decode(forKey: .batting, default: SeasonStatsContent())
            pitching = try container.decode(forKey: .pitching, default: SeasonStatsContent())
        }
        
        init(batting: SeasonStatsContent = SeasonStatsContent(), pitching: SeasonStatsContent = SeasonStatsContent()) {
            self.batting = batting
            self.pitching = pitching
        }
        
        struct SeasonStatsContent: Codable {
            
            let avg, ops, era: String
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                avg = try container.decode(forKey: .avg, default: "")
                ops = try container.decode(forKey: .ops, default: "")
                era = try container.decode(forKey: .era, default: "")
            }
            
            init(avg: String = "", ops: String = "", era: String = "") {
                self.avg = avg
                self.ops = ops
                self.era = era
            }
        }
    }
    
    struct GameStatus: Codable {
        
        let isCurrentBatter, isCurrentPitcher, isOnBench, isSubstitute: Bool
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            isCurrentBatter = try container.decode(forKey: .isCurrentBatter, default: false)
            isCurrentPitcher = try container.decode(forKey: .isCurrentPitcher, default: false)
            isOnBench = try container.decode(forKey: .isOnBench, default: false)
            isSubstitute = try container.decode(forKey: .isSubstitute, default: false)
        }
        
        init(isCurrentBatter: Bool = false, isCurrentPitcher: Bool = false, isOnBench: Bool = false, isSubstitute: Bool = false) {
            self.isCurrentBatter = isCurrentBatter
            self.isCurrentPitcher = isCurrentPitcher
            self.isOnBench = isOnBench
            self.isSubstitute = isSubstitute
        }
    }
}

struct BattingStats: Codable {
    let runs, strikeOuts, baseOnBalls, hits, atBats, rbi, leftOnBase: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        atBats = try container.decode(forKey: .atBats, default: 0)
        runs = try container.decode(forKey: .runs, default: 0)
        hits = try container.decode(forKey: .hits, default: 0)
        rbi = try container.decode(forKey: .rbi, default: 0)
        baseOnBalls = try container.decode(forKey: .baseOnBalls, default: 0)
        strikeOuts = try container.decode(forKey: .strikeOuts, default: 0)
        leftOnBase = try container.decode(forKey: .leftOnBase, default: 0)
    }
    
    init(atBats: Int = 0, runs: Int = 0, hits: Int = 0, rbi: Int = 0, baseOnBalls: Int = 0, strikeOuts: Int = 0, leftOnBase: Int = 0) {
        self.atBats = atBats
        self.runs = runs
        self.hits = hits
        self.rbi = rbi
        self.baseOnBalls = baseOnBalls
        self.strikeOuts = strikeOuts
        self.leftOnBase = leftOnBase
    }
}

struct PitchingStats: Codable {
    let inningsPitched: String
    let hits, runs, earnedRuns, baseOnBalls, strikeOuts, homeRuns: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        inningsPitched = try container.decode(forKey: .inningsPitched, default: "")
        hits = try container.decode(forKey: .hits, default: 0)
        runs = try container.decode(forKey: .runs, default: 0)
        earnedRuns = try container.decode(forKey: .earnedRuns, default: 0)
        baseOnBalls = try container.decode(forKey: .baseOnBalls, default: 0)
        strikeOuts = try container.decode(forKey: .strikeOuts, default: 0)
        homeRuns = try container.decode(forKey: .homeRuns, default: 0)
    }
    
    init(inningsPitched: String = "", hits: Int = 0, runs: Int = 0, earnedRuns: Int = 0, baseOnBalls: Int = 0, strikeOuts: Int = 0, homeRuns: Int = 0) {
        self.inningsPitched = inningsPitched
        self.hits = hits
        self.runs = runs
        self.earnedRuns = earnedRuns
        self.baseOnBalls = baseOnBalls
        self.strikeOuts = strikeOuts
        self.homeRuns = homeRuns
    }
}
