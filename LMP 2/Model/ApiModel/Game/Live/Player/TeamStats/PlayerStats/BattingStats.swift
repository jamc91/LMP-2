//
//  BattingStats.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct BattingStats: Codable {
    let runs, strikeOuts, baseOnBalls, hits, atBats, rbi, leftOnBase: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        atBats = try container.decode(forKey: .atBats, default: 0)
        runs = try container.decode(forKey: .runs, default: 0)
        hits = try container.decode(forKey: .hits, default: 0)
        rbi = try container.decode(forKey: .rbi, default: 0)
        baseOnBalls = try container.decode(forKey: .baseOnBalls, default: 0)
        strikeOuts = try container.decode(forKey: .strikeOuts, default: 0)
        leftOnBase = try container.decode(forKey: .leftOnBase, default: 0)
    }
    
    init(atBats: Int = 0, runs: Int = 0, hits: Int = 0, rbi: Int = 0, baseOnBalls: Int = 0, strikeOuts: Int = 0, leftOnBase: Int = 0) {
        self.atBats = atBats
        self.runs = runs
        self.hits = hits
        self.rbi = rbi
        self.baseOnBalls = baseOnBalls
        self.strikeOuts = strikeOuts
        self.leftOnBase = leftOnBase
    }
}
