//
//  ScoreboardModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

enum ScoreboardLoadingState {
    case empty, loading, loaded
}

struct ScoreboardModel: Codable {
    
    let totalGamesInProgress: Int
    let dates: [Dates]
    
    init() {
        totalGamesInProgress = 0
        dates = [Dates]()
    }
}

struct Dates: Identifiable, Codable {
    var id = UUID()
    let games: [Games]
    
    enum CodingKeys: String, CodingKey {
        case games
    }
}



struct Games: Identifiable, Codable {
    var id = UUID()
    let gamePk: Int
    let gameDate: String
    let status: Status
    let teams: Teams
    let linescore: Linescore
    let decisions: Decisions
    let venue: Venue
    
    enum CodingKeys: String, CodingKey {
        case gamePk, gameDate, status, teams, linescore, decisions, venue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        gamePk = try container.decode(forKey: .gamePk, default: 0)
        gameDate = try container.decode(forKey: .gameDate, default: "")
        status = try container.decode(forKey: .status, default: Status())
        teams = try container.decode(forKey: .teams, default: Teams())
        linescore = try container.decode(forKey: .linescore, default: Linescore())
        decisions = try container.decode(forKey: .decisions, default: Decisions())
        venue = try container.decode(forKey: .venue, default: Venue())
    }
}

extension Games {
    static var data: [Games] {
        let path = Bundle.main.path(forResource: "schedule", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        if let data = try? Data(contentsOf: url),let schedule = try? JSONDecoder().decode(ScoreboardModel.self, from: data) {
            let games = schedule.dates.flatMap { $0.games }
            return games
        } else {
            return [Games]()
        }
    }
}
