//
//  Game.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import SwiftUI

struct Game: Identifiable, Codable {
    var id = UUID()
    let gamePk: Int
    let gameDate: String
    let status: Status
    let teams: Teams<TeamContent>
    let linescore: Linescore?
    let decisions: Decisions
    let venue: Venue
    
    enum CodingKeys: String, CodingKey {
        case gamePk, gameDate, status, teams, linescore, decisions, venue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        gamePk = try container.decode(forKey: .gamePk, default: 0)
        gameDate = try container.decode(forKey: .gameDate, default: "")
        status = try container.decode(forKey: .status, default: Status())
        teams = try container.decode(Teams.self, forKey: .teams)
        linescore = try container.decode(forKey: .linescore, default: nil)
        decisions = try container.decode(forKey: .decisions, default: Decisions())
        venue = try container.decode(forKey: .venue, default: Venue())
    }
}
