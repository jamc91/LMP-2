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

enum TypeStanding: String, CaseIterable {
    case First, Second, General, Points, Playoffs, Semifinal, Final
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

extension StandingRegular {
    static var data: [StandingRegular] { [
        .init(name: "Obregon", teamName: "OBR", wins: 21, losses: 8, percent: ".754", gb: "--", pts: "10.0"),
        .init(name: "Hermosillo", teamName: "HER", wins: 15, losses: 11, percent: ".577", gb: "4.5", pts: "9.0"),
        .init(name: "Monterrey", teamName: "MTY", wins: 14, losses: 12, percent: ".538", gb: "5.5", pts: "8.0"),
        .init(name: "Culiacan", teamName: "CUL", wins: 15, losses: 13, percent: ".536", gb: "5.5", pts: "7.0"),
        .init(name: "Guasave", teamName: "GSV", wins: 14, losses: 13, percent: ".519", gb: "6.0", pts: "6.0"),
        .init(name: "Jalisco", teamName: "JAL", wins: 15, losses: 14, percent: ".517", gb: "6.0", pts: "5.5"),
        .init(name: "Mazatlan", teamName: "MAZ", wins: 14, losses: 14, percent: ".500", gb: "6.5", pts: "5.0"),
        .init(name: "Mexicali", teamName: "MXC", wins: 13, losses: 16, percent: ".448", gb: "8.0", pts: "6.5"),
        .init(name: "Navojoa", teamName: "NAV", wins: 10, losses: 19, percent: ".345", gb: "11.0", pts: "4.0"),
        .init(name: "Obregon", teamName: "OBR", wins: 9, losses: 20, percent: ".310", gb: "12.0", pts: "3.5")
    ]
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
