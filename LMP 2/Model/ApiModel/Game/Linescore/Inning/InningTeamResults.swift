//
//  InningTeamResults.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 13/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct InningTeamResults: Codable {
    let runs: Int?
    let hits, errors, leftOnBase: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        runs = try container.decode(forKey: .runs, default: nil)
        hits = try container.decode(forKey: .hits, default: 0)
        errors = try container.decode(forKey: .errors, default: 0)
        leftOnBase = try container.decode(forKey: .leftOnBase, default: 0)
    }
}
