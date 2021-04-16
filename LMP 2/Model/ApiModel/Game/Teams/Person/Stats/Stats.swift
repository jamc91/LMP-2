//
//  Stats.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Stats: Codable, Identifiable {
    var id = UUID()
    var type: DisplayName
    var group: DisplayName
    var stats: StatsContent
    
    enum CodingKeys: String, CodingKey {
        case type, group, stats
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(forKey: .type, default: DisplayName())
        group = try container.decode(forKey: .group, default: DisplayName())
        stats = try container.decode(forKey: .stats, default: StatsContent())
    }
    
    init() {
        type = DisplayName()
        group = DisplayName()
        stats = StatsContent()
    }
}
