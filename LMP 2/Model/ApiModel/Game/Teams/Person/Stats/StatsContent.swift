//
//  StatsContent.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct StatsContent: Codable {
    var era: String
    var wins, losses: Int
    
    enum CodingKeys: String, CodingKey {
        case era, wins, losses
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        era = try container.decode(forKey: .era, default: "-.-- ERA")
        wins = try container.decode(forKey: .wins, default: 0)
        losses = try container.decode(forKey: .losses, default: 0)
    }
    
    init() {
        era = "--"
        wins = 0
        losses = 0
    }
}
