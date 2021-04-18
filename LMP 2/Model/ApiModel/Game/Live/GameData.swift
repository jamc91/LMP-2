//
//  GameData.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct GameData: Codable {
    
    let datetime: DateTime
    let status: Status
    let teams: Teams<TeamInformation>
    let players: [String: Person]
    let venue: Venue
    let probablePitchers: Teams<Person>?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        datetime = try container.decode(forKey: .datetime, default: DateTime())
        status = try container.decode(forKey: .status, default: Status())
        teams = try container.decode(Teams.self, forKey: .teams)
        players = try container.decode(forKey: .players, default: [String : Person]())
        venue = try container.decode(forKey: .venue, default: Venue())
        probablePitchers = try container.decode(Teams.self, forKey: .probablePitchers)
    }
    
    init(datetime: DateTime = DateTime(), status: Status = Status(), teams: Teams<TeamInformation>, players: [String: Person] = [String : Person](), venue: Venue = Venue(), probablePitchers: Teams<Person>) {
        self.datetime = datetime
        self.status = status
        self.teams = teams
        self.players = players
        self.venue = venue
        self.probablePitchers = probablePitchers
    }
}
