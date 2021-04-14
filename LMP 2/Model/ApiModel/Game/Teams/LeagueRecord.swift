//
//  LeagueRecord.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct LeagueRecord: Codable {
    let wins: Int
    let losses: Int
    let pct: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        wins = try container.decode(forKey: .wins, default: 0)
        losses = try container.decode(forKey: .losses, default: 0)
        pct = try container.decode(forKey: .pct, default: "")
    }
    
    init(wins: Int = 0, losses: Int = 0, pct: String = "") {
        self.wins = wins
        self.losses = losses
        self.pct = pct
    }
}
