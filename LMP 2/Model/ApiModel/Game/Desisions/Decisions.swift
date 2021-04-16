//
//  Decisions.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Decisions: Codable {
    let winner, loser, save: Person
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        winner = try container.decode(forKey: .winner, default: Person())
        loser = try container.decode(forKey: .loser, default: Person())
        save = try container.decode(forKey: .save, default: Person())
    }
    
    init(winner: Person = Person(), loser: Person = Person(), save: Person = Person()) {
        self.winner = winner
        self.loser = loser
        self.save = save
    }
}
