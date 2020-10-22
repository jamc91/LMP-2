//
//  LMPModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct LMPModelResults: Codable {
    var response: [GamesLMP]
    
    static var `default` = LMPModelResults(response: [GamesLMP]())
}

struct GamesLMP: Codable {
    
       // var id = UUID()
        let gameStatus: Int
        let gameTime, awayTeam: String
        let awayRuns: Int
        let homeTeam: String
        let homeRuns: Int
        let diamond, balls, strikes, outs: String
        let inningArrow, inningCurrent, footer: String
        let gamedayLink: String
        let streaming: String
        let boxScore: Int
        let awayProbablePitcher: String
        let awayProbablePitcherMlbid: Int
        let awayProbablePitcherEra: String
        let awayProbablePitcherWins, awayProbablePitcherLosses: Int
        let homeProbablePitcher: String
        let homeProbablePitcherMlbid: Int
        let homeProbablePitcherEra: String
        let homeProbablePitcherWins, homeProbablePitcherLosses: Int
        let winPitcher: String
        let winPitcherMlbid: SafeValue
        let winPitcherEra: String
        let winPitcherWins, winPitcherLosses: SafeValue
        let losePitcher: String
        let losePitcherMlbid: SafeValue
        let losePitcherEra: String
        let losePitcherWins, losePitcherLosses: SafeValue
        let stadium: String
        let awayTeamWins, awayTeamLosses, homeTeamWins, homeTeamLosses: Int
        let scores: [Score]
        let awayHomes, awayErrors, homeHomes, homeErrors: Int
        let winPitcherTeam, losePitcherTeam, atBatTeam, atBat: String
        let atBatAvg: String
        let atBatWins, atBatLosses: Int
        let pitcherTeam, pitcher, pitcherEra: String
        let pitcherWins, pitcherLosses: Int

}

enum SafeValue: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(SafeValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SafeValue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Score
struct Score: Codable {
    let inning, awayRuns, awayHits, awayErrors: String
    let homeRuns, homeHits, homeErrors: String
    
    enum CodingKeys: String, CodingKey {
        case inning
        case awayRuns = "away_runs"
        case awayHits = "away_hits"
        case awayErrors = "away_errors"
        case homeRuns = "home_runs"
        case homeHits = "home_hits"
        case homeErrors = "home_errors"
    }
}
