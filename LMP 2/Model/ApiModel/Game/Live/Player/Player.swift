//
//  Player.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Player: Codable {
    let boxscoreName: String
    let fullName: String
    let position: Position
    let stats: TeamStats
    let seasonStats: SeasonStats
    let gameStatus: PlayerStatus
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        boxscoreName = try container.decode(forKey: .boxscoreName, default: "")
        fullName = try container.decode(forKey: .fullName, default: "")
        position = try container.decode(forKey: .position, default: Position())
        stats = try container.decode(forKey: .stats, default: TeamStats())
        seasonStats = try container.decode(forKey: .seasonStats, default: SeasonStats())
        gameStatus = try container.decode(forKey: .gameStatus, default: PlayerStatus())
    }
    
    init(boxscoreName: String = "", fullName: String = "", position: Position = Position(), stats: TeamStats = TeamStats(), seasonStats: SeasonStats = SeasonStats(), gameStatus: PlayerStatus = PlayerStatus()) {
        self.boxscoreName = boxscoreName
        self.fullName = fullName
        self.position = position
        self.stats = stats
        self.seasonStats = seasonStats
        self.gameStatus = gameStatus
    }
}
