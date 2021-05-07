//
//  PitchingStats.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct PitchingStats: Codable {
    let inningsPitched: String
    let hits, runs, earnedRuns, baseOnBalls, strikeOuts, homeRuns: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        inningsPitched = try container.decode(forKey: .inningsPitched, default: "")
        hits = try container.decode(forKey: .hits, default: 0)
        runs = try container.decode(forKey: .runs, default: 0)
        earnedRuns = try container.decode(forKey: .earnedRuns, default: 0)
        baseOnBalls = try container.decode(forKey: .baseOnBalls, default: 0)
        strikeOuts = try container.decode(forKey: .strikeOuts, default: 0)
        homeRuns = try container.decode(forKey: .homeRuns, default: 0)
     
    }
    
    init(inningsPitched: String = "", hits: Int = 0, runs: Int = 0, earnedRuns: Int = 0, baseOnBalls: Int = 0, strikeOuts: Int = 0, homeRuns: Int = 0) {
        self.inningsPitched = inningsPitched
        self.hits = hits
        self.runs = runs
        self.earnedRuns = earnedRuns
        self.baseOnBalls = baseOnBalls
        self.strikeOuts = strikeOuts
        self.homeRuns = homeRuns
    }
}
