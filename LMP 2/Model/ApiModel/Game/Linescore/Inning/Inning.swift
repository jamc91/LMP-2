//
//  Inning.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 13/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Inning: Identifiable, Codable {
    var id = UUID()
    let num: Int
    let away, home: InningTeamResults
    
    enum CodingKeys: String, CodingKey {
        case num, away, home
    }
    
    init(num: Int = 0, away: InningTeamResults = InningTeamResults(), home: InningTeamResults = InningTeamResults()) {
        self.num = num
        self.away = away
        self.home = home
    }
}
