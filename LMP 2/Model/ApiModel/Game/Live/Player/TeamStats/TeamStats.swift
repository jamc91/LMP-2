//
//  TeamStats.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct TeamStats: Codable {
    let batting: BattingStats
    let pitching: PitchingStats
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        batting = try container.decode(forKey: .batting, default: BattingStats())
        pitching = try container.decode(forKey: .pitching, default: PitchingStats())
    }
    
    init(batting: BattingStats = BattingStats(), pitching: PitchingStats = PitchingStats()) {
        self.batting = batting
        self.pitching = pitching
    }
    
}
