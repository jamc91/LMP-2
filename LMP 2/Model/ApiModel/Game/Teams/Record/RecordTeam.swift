//
//  RecordTeam.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct RecordTeam: Codable {
    let gamesPlayed: Int
    let wins: Int
    let losses: Int
    let winningPercentage: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        gamesPlayed = try container.decode(forKey: .gamesPlayed, default: 0)
        wins = try container.decode(forKey: .wins, default: 0)
        losses = try container.decode(forKey: .losses, default: 0)
        winningPercentage = try container.decode(forKey: .winningPercentage, default: "")
    }
    
    init() {
        gamesPlayed = 0
        wins = 0
        losses = 0
        winningPercentage = ""
    }
}
