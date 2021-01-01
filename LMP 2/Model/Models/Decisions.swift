//
//  Decisions.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Decisions: Codable {
    let winner, loser, save: ProbablePitcher
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        winner = try container.decode(forKey: .winner, default: ProbablePitcher())
        loser = try container.decode(forKey: .loser, default: ProbablePitcher())
        save = try container.decode(forKey: .save, default: ProbablePitcher())
    }
    
    init(winner: ProbablePitcher = ProbablePitcher(), loser: ProbablePitcher = ProbablePitcher(), save: ProbablePitcher = ProbablePitcher()) {
        self.winner = winner
        self.loser = loser
        self.save = save
    }
}
