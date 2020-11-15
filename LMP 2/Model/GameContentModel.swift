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
    var players: [String : PlayersInfo]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        teams = try container.decode(forKey: .teams, default: CGTeams())
        players = try container.decode(forKey: .players, default: [String : PlayersInfo]())
    }
    
    init() {
        teams = CGTeams()
        players = [String : PlayersInfo]()
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
    var teams: BoxscoreTeams
    var info: [FieldListInfo]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        teams = try container.decode(forKey: .teams, default: BoxscoreTeams())
        info = try container.decode(forKey: .info, default: [FieldListInfo]())
    }
    
    init() {
        teams = BoxscoreTeams()
        info = [FieldListInfo]()
    }
}

struct CDecisions: Codable {
    
}

struct CLeaders: Codable {
    
}

struct BoxscoreTeams: Codable {
    var away, home: BoxscoreTeamsInfo
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        away = try container.decode(forKey: .away, default: BoxscoreTeamsInfo())
        home = try container.decode(forKey: .home, default: BoxscoreTeamsInfo())
    }
    
    init() {
        away = BoxscoreTeamsInfo()
        home = BoxscoreTeamsInfo()
    }
}

struct BoxscoreTeamsInfo: Codable {
    var team: BTeamInfo
    var teamStats: BTeamStats
    var players: [String : PlayersInfo]
    var batters: [Int]
    var pitchers: [Int]
    var bench: [Int]
    var bullpen: [Int]
    var battingOrder: [Int]
    var info: [BInfoSection]
    var note: [FieldListInfo]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        team = try container.decode(forKey: .team, default: BTeamInfo())
        teamStats = try container.decode(forKey: .teamStats, default: BTeamStats())
        players = try container.decode(forKey: .players, default: [String:PlayersInfo]())
        batters = try container.decode(forKey: .batters, default: [Int]())
        pitchers = try container.decode(forKey: .pitchers, default: [Int]())
        bench = try container.decode(forKey: .bench, default: [Int]())
        bullpen = try container.decode(forKey: .bullpen, default: [Int]())
        battingOrder = try container.decode(forKey: .battingOrder, default: [Int]())
        info = try container.decode(forKey: .info, default: [BInfoSection]())
        note = try container.decode(forKey: .note, default: [FieldListInfo]())
    }
    
    init() {
        team = BTeamInfo()
        teamStats = BTeamStats()
        players = [String:PlayersInfo]()
        batters = [Int]()
        pitchers = [Int]()
        bench = [Int]()
        bullpen = [Int]()
        battingOrder = [Int]()
        info = [BInfoSection]()
        note = [FieldListInfo]()
    }
}

struct PlayersInfo: Codable {
    var boxscoreName: String
    var person: PersonInfo
    var jerseyNumber: String
    var stats: PlayerStats
    var seasonStats: PlayerSeasonStats
    var position: PlayerPositionInfo
    var gameStatus: PlayerGameStatus
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        boxscoreName = try container.decode(forKey: .boxscoreName, default: "")
        person = try container.decode(forKey: .person, default: PersonInfo())
        jerseyNumber = try container.decode(forKey: .jerseyNumber, default: "")
        stats = try container.decode(forKey: .stats, default: PlayerStats())
        seasonStats = try container.decode(forKey: .seasonStats, default: PlayerSeasonStats())
        position = try container.decode(forKey: .position, default: PlayerPositionInfo())
        gameStatus = try container.decode(forKey: .gameStatus, default: PlayerGameStatus())
    }
    
    init() {
        boxscoreName = ""
        person = PersonInfo()
        jerseyNumber = ""
        stats = PlayerStats()
        seasonStats = PlayerSeasonStats()
        position = PlayerPositionInfo()
        gameStatus = PlayerGameStatus()
    }
}

struct PersonInfo: Codable {
    var id: Int
    var fullName: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        fullName = try container.decode(forKey: .fullName, default: "")
    }
    
    init() {
        id = 0
        fullName = ""
    }
    
}

struct PlayerStats: Codable {
    var batting: BattingStats
    var pitching: PitchingStats
    var fielding: FieldingStats
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        batting = try container.decode(forKey: .batting, default: BattingStats())
        pitching = try container.decode(forKey: .pitching, default: PitchingStats())
        fielding = try container.decode(forKey: .fielding, default: FieldingStats())
        
    }
    
    init() {
        batting = BattingStats()
        pitching = PitchingStats()
        fielding = FieldingStats()
    }
}

struct BattingStats: Codable {
    var atBats: Int
    var runs: Int
    var hits: Int
    var rbi: Int
    var baseOnBalls: Int
    var strikeOuts: Int
    var leftOnBase: Int
    
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
    
    init() {
        atBats = 0
        runs = 0
        hits = 0
        rbi = 0
        baseOnBalls = 0
        strikeOuts = 0
        leftOnBase = 0
    }
}

struct PitchingStats: Codable {
    var inningsPitched: String
    var hits: Int
    var runs: Int
    var earnedRuns: Int
    var baseOnBalls: Int
    var strikeOuts: Int
    var homeRuns: Int
    
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
    
    init() {
        inningsPitched = ""
        hits = 0
        runs = 0
        earnedRuns = 0
        baseOnBalls = 0
        strikeOuts = 0
        homeRuns = 0
    }
    
}

struct FieldingStats: Codable {
    
}

struct PlayerSeasonStats: Codable {
    var batting: BattingSeasonStats
    var pitching: PitchingSeasonStats
    var fielding: FieldingSeasonStats
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        batting = try container.decode(forKey: .batting, default: BattingSeasonStats())
        pitching = try container.decode(forKey: .pitching, default: PitchingSeasonStats())
        fielding = try container.decode(forKey: .fielding, default: FieldingSeasonStats())
    }
    
    init() {
        batting = BattingSeasonStats()
        pitching = PitchingSeasonStats()
        fielding = FieldingSeasonStats()
    }
}

struct BattingSeasonStats: Codable {
    var avg: String
    var ops: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        avg = try container.decode(forKey: .avg, default: "")
        ops = try container.decode(forKey: .ops, default: "")
    }
    
    init() {
        avg = ""
        ops = ""
    }
}

struct PitchingSeasonStats: Codable {
    var era: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        era = try container.decode(forKey: .era, default: "")
    }
    
    init() {
        era = ""
    }
}

struct FieldingSeasonStats: Codable {
    
}

struct PlayerPositionInfo: Codable {
    var code: String
    var name: String
    var type: String
    var abbreviation: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try container.decode(forKey: .code, default: "")
        name = try container.decode(forKey: .name, default: "")
        type = try container.decode(forKey: .type, default: "")
        abbreviation = try container.decode(forKey: .abbreviation, default: "")
    }
    
    init() {
        code = ""
        name = ""
        type = ""
        abbreviation = ""
    }
}

struct BTeamStats: Codable {
    var batting: BTeamBattingStats
    var pitching: BTeamPitchingStats
    
    init() {
        batting = BTeamBattingStats()
        pitching = BTeamPitchingStats()
    }
}

struct BTeamBattingStats: Codable {
    var runs: Int
    var strikeOuts: Int
    var baseOnBalls: Int
    var hits: Int
    var atBats: Int
    var rbi: Int
    var leftOnBase: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        runs = try container.decode(forKey: .runs, default: 0)
        strikeOuts = try container.decode(forKey: .strikeOuts, default: 0)
        baseOnBalls = try container.decode(forKey: .baseOnBalls, default: 0)
        hits = try container.decode(forKey: .hits, default: 0)
        atBats = try container.decode(forKey: .atBats, default: 0)
        rbi = try container.decode(forKey: .rbi, default: 0)
        leftOnBase = try container.decode(forKey: .leftOnBase, default: 0)
    }
    
    init() {
        runs = 0
        strikeOuts = 0
        baseOnBalls = 0
        hits = 0
        atBats = 0
        rbi = 0
        leftOnBase = 0
    }
    
}

struct BTeamPitchingStats: Codable {
    var inningsPitched: String
    var hits: Int
    var runs: Int
    var earnedRuns: Int
    var baseOnBalls: Int
    var strikeOuts: Int
    var homeRuns: Int
    
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
    
    init() {
        inningsPitched = ""
        hits = 0
        runs = 0
        earnedRuns = 0
        baseOnBalls = 0
        strikeOuts = 0
        homeRuns = 0
    }
}

struct BTeamInfo: Codable {
    var id: Int
    var name: String
    var link: String
    var allStarStatus: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(forKey: .id, default: 0)
        name = try container.decode(forKey: .name, default: "")
        link = try container.decode(forKey: .link, default: "")
        allStarStatus = try container.decode(forKey: .allStarStatus, default: "")
    }
    
    init() {
        id = 0
        name = ""
        link = ""
        allStarStatus = ""
    }
}

struct BInfoSection: Codable, Identifiable {
    var id = UUID()
    var title: String
    var fieldList: [FieldListInfo]
    
    enum CodingKeys: String, CodingKey {
        case title, fieldList
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(forKey: .title, default: "")
        fieldList = try container.decode(forKey: .fieldList, default: [FieldListInfo]())
    }
    
    init() {
        title = ""
        fieldList = [FieldListInfo]()
    }
}

struct FieldListInfo: Codable, Identifiable {
    var id = UUID()
    var label: String
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case label, value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        label = try container.decode(forKey: .label, default: "")
        value = try container.decode(forKey: .value, default: "")
    }
    
    init() {
        label = ""
        value = ""
    }
}

struct PlayerGameStatus: Codable {
    var isCurrentBatter: Bool
    var isCurrentPitcher: Bool
    var isOnBench: Bool
    var isSubstitute: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        isCurrentBatter = try container.decode(forKey: .isCurrentBatter, default: false)
        isCurrentPitcher = try container.decode(forKey: .isCurrentPitcher, default: false)
        isOnBench = try container.decode(forKey: .isOnBench, default: false)
        isSubstitute = try container.decode(forKey: .isSubstitute, default: false)
    }
    
    init() {
        isCurrentBatter = false
        isCurrentPitcher = false
        isOnBench = false
        isSubstitute = false
    }
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
