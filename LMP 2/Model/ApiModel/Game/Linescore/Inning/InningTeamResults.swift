//
//  InningTeamResults.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 13/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct InningTeamResults: Codable {
    let runs, hits, errors, leftOnBase: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        runs = try container.decode(forKey: .runs, default: 0)
        hits = try container.decode(forKey: .hits, default: 0)
        errors = try container.decode(forKey: .errors, default: 0)
        leftOnBase = try container.decode(forKey: .leftOnBase, default: 0)
    }
    
    init(runs: Int = 0, hits: Int = 0, errors: Int = 0, leftOnBase: Int = 0) {
        self.runs = runs
        self.hits = hits
        self.errors = errors
        self.leftOnBase = leftOnBase
    }
}
