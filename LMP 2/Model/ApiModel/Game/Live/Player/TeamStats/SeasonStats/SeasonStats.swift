//
//  SeasonStats.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct SeasonStats: Codable {
    let batting: SeasonStatsContent
    let pitching: SeasonStatsContent
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        batting = try container.decode(forKey: .batting, default: SeasonStatsContent())
        pitching = try container.decode(forKey: .pitching, default: SeasonStatsContent())
    }
    
    init(batting: SeasonStatsContent = SeasonStatsContent(), pitching: SeasonStatsContent = SeasonStatsContent()) {
        self.batting = batting
        self.pitching = pitching
    }
}
