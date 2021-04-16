//
//  GameData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct GameData: Codable {
        let status: Status
        let teams: TeamsLinescore
        let players: [String: Person]
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            status = try container.decode(forKey: .status, default: Status())
            teams = try container.decode(forKey: .teams, default: TeamsLinescore())
            players = try container.decode(forKey: .players, default: [String : Person]())
        }
        
        init(status: Status = Status(), teams: TeamsLinescore = TeamsLinescore(), players: [String: Person] = [String : Person]()) {
            self.status = status
            self.teams = teams
            self.players = players
    }
}
