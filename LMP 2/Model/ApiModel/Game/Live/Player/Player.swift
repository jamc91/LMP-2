//
//  Player.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Player: Codable {
    let person: Person
    let jerseyNumber: String
    let position: PrimaryPosition
    let stats: TeamStats
    let seasonStats: SeasonStats
    let gameStatus: PlayerStatus
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        person = try container.decode(forKey: .person, default: Person())
        jerseyNumber = try container.decode(forKey: .jerseyNumber, default: "")
        position = try container.decode(forKey: .position, default: PrimaryPosition())
        stats = try container.decode(forKey: .stats, default: TeamStats())
        seasonStats = try container.decode(forKey: .seasonStats, default: SeasonStats())
        gameStatus = try container.decode(forKey: .gameStatus, default: PlayerStatus())
    }
    
    init(person: Person = Person(), jerseyNumber: String, position: PrimaryPosition = PrimaryPosition(), stats: TeamStats = TeamStats(), seasonStats: SeasonStats = SeasonStats(), gameStatus: PlayerStatus = PlayerStatus()) {
        
        self.person = person
        self.jerseyNumber = jerseyNumber
        self.position = position
        self.stats = stats
        self.seasonStats = seasonStats
        self.gameStatus = gameStatus
    }
}
