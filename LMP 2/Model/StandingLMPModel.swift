//
//  StandingsData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 21/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct StandingLMP: Codable {
    let response: Standing
    
    init() {
        response = Standing(first: [], second: [], general: [], points: [], playoffs: nil)
    }
}

struct Standing: Codable {
    let first, second, general: [StandingRegular]
    let points: [StandingPoints]
    let playoffs: StandingPlayoffs?
    
}

struct StandingRegular: Codable, Identifiable {
    var id = UUID()
    let name: String
    let teamName: String
    let wins: Int
    let losses: Int
    let percent: String
    let gb: String
    let pts: String
    
    enum CodingKeys: String, CodingKey {
        case name, wins, losses, percent, gb, pts
        case teamName = "team_name"
    }
}

struct StandingPoints: Codable, Identifiable {
    var id = UUID()
    let name: String
    let teamName: String
    let percent: String
    let runAverage: String
    let first: String
    let second: String
    let total: String
    
    enum CodingKeys: String, CodingKey {
        case name, percent, first, second, total
        case teamName = "team_name", runAverage = "run_average"
    }
}

struct StandingPlayoffs: Codable {
    let repesca, semifinal, final: [StandingPlayoffsElements]
}

struct StandingPlayoffsElements: Codable {
    var id = UUID()
    let awayTeamName, awayImage: String
    let awayWins, awayLosses: Int
    let awayPercent, awayRunsAvg, awayGamesPlayed, homeTeamName: String
    let homeImage: String
    let homeWins, homeLosses: Int
    let homePercent, homeRunsAvg: String
    let homeGamesPlayed: String

    enum CodingKeys: String, CodingKey {
        case awayTeamName = "away_team_name"
        case awayImage = "away_image"
        case awayWins = "away_wins"
        case awayLosses = "away_losses"
        case awayPercent = "away_percent"
        case awayRunsAvg = "away_runs_avg"
        case awayGamesPlayed = "away_games_played"
        case homeTeamName = "home_team_name"
        case homeImage = "home_image"
        case homeWins = "home_wins"
        case homeLosses = "home_losses"
        case homePercent = "home_percent"
        case homeRunsAvg = "home_runs_avg"
        case homeGamesPlayed = "home_games_played"
    }
}
