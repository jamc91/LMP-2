//
//  Decisions.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Decisions: Codable {
    let winner, loser, save: People
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        winner = try container.decode(forKey: .winner, default: People())
        loser = try container.decode(forKey: .loser, default: People())
        save = try container.decode(forKey: .save, default: People())
    }
    
    init(winner: People = People(), loser: People = People(), save: People = People()) {
        self.winner = winner
        self.loser = loser
        self.save = save
    }
}
