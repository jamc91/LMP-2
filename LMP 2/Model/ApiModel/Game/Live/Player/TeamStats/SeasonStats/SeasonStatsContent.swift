//
//  SeasonStatsContent.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct SeasonStatsContent: Codable {
    
    let avg, ops, era: String
    let wins, losses: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        avg = try container.decode(forKey: .avg, default: "")
        ops = try container.decode(forKey: .ops, default: "")
        era = try container.decode(forKey: .era, default: "")
        wins = try container.decode(forKey: .wins, default: 0)
        losses = try container.decode(forKey: .losses, default: 0)
    }
    
    init(avg: String = "", ops: String = "", era: String = "", wins: Int = 0, losses: Int = 0) {
        self.avg = avg
        self.ops = ops
        self.era = era
        self.wins = wins
        self.losses = losses
    }
}
